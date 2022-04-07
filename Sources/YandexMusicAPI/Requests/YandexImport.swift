//
//  YandexImport.swift
//  MusicImport
//
//  Created by Daniil on 11.03.2020.
//  Copyright © 2020 Данил Войдилов. All rights reserved.
//

import Foundation
import VDCodable
import SwiftHttp

extension Yandex.Music.API {
	public enum Import {
		public static var baseURL = HttpUrl(host: "music.yandex.ru")
	}
}

extension Yandex.Music.API {

	public func importSearch(_ tracks: [E3U.Line]) async throws -> [YMO.Track] {
		let e3u = E3U(lines: tracks)
		let code = try await importFile(e3u: e3u).importCode
		var result = try await importCode(code)
		while result.status.asEnum == .inProgress {
			sleep(2)
			result = try await importCode(code)
		}
		guard result.status.asEnum == .done, let tracks = result.tracks else {
			throw UnknownError()
		}
		return tracks
	}
}

extension Yandex.Music.API {

	public func importFile(e3u: E3U) async throws -> ImportFileOutput {
		let response = try await encodableRequest(
				executor: client.dataTask,
				url: Yandex.Music.API.Import.baseURL.path("handlers").resource("import-file.jsx"),
				method: .post,
				headers: [
					.key(.contentType): "text/plain",
					.custom("Connection"): "keep-alive"
				],
				body: E3U.Formatter().convert(e3u)
		)
		return try VDJSONDecoder().decode(ImportFileOutput.self, from: response.data)
	}

	public struct ImportFileOutput: Codable {
		public let importCode: String
	}
}

extension Yandex.Music.API {

	public func importCode(_ code: String) async throws -> ImportCodeOutput {
		let response = try await rawRequest(
				executor: client.dataTask,
				url: Yandex.Music.API.Import.baseURL
						.path("handlers").resource("import.jsx")
						.query("code", code),
				method: .post
		)
		return try VDJSONDecoder().decode(ImportCodeOutput.self, from: response.data)
	}

	public struct ImportCodeOutput: Codable {
		public var status: RawEnum<Status>
		public var tracks: [YMO.Track]?

		public enum Status: String, Codable {
			case done, inProgress = "in-progress", failure
		}
	}
}

extension Yandex.Music.Objects {

	public struct ImportResult<T: Codable>: Codable {
		public let success: Bool
		public var object: T

		public enum CodingKeys: String, CodingKey {
			case success
		}

		public init(from decoder: Decoder) throws {
			object = try T.init(from: decoder)
			let container = try decoder.container(keyedBy: CodingKeys.self)
			success = try container.decode(Bool.self, forKey: .success)
		}

		public func encode(to encoder: Encoder) throws {
			try object.encode(to: encoder)
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(success, forKey: .success)
		}
	}
}

public struct UnknownError: Error {}