//
//  Tracks.swift
//  MusicImport
//
//  Created by crypto_user on 30.12.2019.
//  Copyright © 2019 Данил Войдилов. All rights reserved.
//

import Foundation
import SwiftHttp
import VDCodable
import SimpleCoders

extension Yandex.Music.API {

    public func tracks(ids: [Int], withPositions: Bool = true) async throws -> [YMO.Track] {
        try await request(
            url: baseURL.path("tracks").query(
                from: TracksInput(ids: ids, withPositions: withPositions),
                encoder: queryEncoder
            ),
            method: .post
        )
    }

    public struct TracksInput: Encodable {
        public var ids: [Int]
        public var withPositions: Bool = true

        enum CodingKeys: String, CodingKey {
            case ids = "track-ids", withPositions = "with-positions"
        }

        public init(ids: [Int], withPositions: Bool = true) {
            self.ids = ids
            self.withPositions = withPositions
        }
    }
}

extension Yandex.Music.API {

    public func tracksDownloadInfo(id: Int) async throws -> [YMO.DownloadInfo] {
        try await request(
            url: baseURL.path("tracks", "\(id)", "download-info"),
            method: .get
        )
    }
}

extension Yandex.Music.API {
    public func fileURL(xmlURL: URL, codec: YMO.Codec, trackId: Int, uid: Int) async throws -> URL {
        guard let url = HttpUrl(url: xmlURL) else { throw InvalidUrl() }
        let response = try await rawRequest(
            executor: client.dataTask,
            url: url,
            method: .get,
            headers: headers()
        )

        guard let xml = String(data: response.data, encoding: .utf8) else {
            throw DecodingError.dataCorrupted(DecodingError.Context(codingPath: [], debugDescription: "No XML"))
        }

        let host = try getXML(at: "host", xml: xml)
        let path = try getXML(at: "path", xml: xml)
        let ts = try getXML(at: "ts", xml: xml)
        let s = try getXML(at: "s", xml: xml)
//            let region = getXML(at: "region", xml: xml).flatMap(Int.init)
        var base = URL(string: "https://" + host) ?? Yandex.Music.API.baseURL.url
        base.appendPathComponent("get-\(codec.rawValue)/\(MD5(String(path.dropFirst()) + s))/\(ts)\(path)")
        let parameters = Parameters(trackId: trackId, uid: uid)
        return try URLQueryEncoder().encode(parameters, for: base)
    }

    private func getXML(at key: String, xml: String) throws -> String {
        let all = xml.components(separatedBy: "<\(key)>")
        guard !all.isEmpty,
              let result = all.dropFirst()
                  .compactMap({ $0.components(separatedBy: "</\(key)>").first })
                  .first else {
            throw DecodingError.keyNotFound(PlainCodingKey(key), DecodingError.Context(codingPath: [], debugDescription: ""))
        }
        return result
    }

    private struct Parameters: Encodable {
        let trackId: Int
        let uid: Int
        let from = "mobile"
        let play = false

        private enum CodingKeys: String, CodingKey {
            case trackId = "track-id", uid, from, play
        }
    }
}

public struct InvalidUrl: Error { public init() {} }