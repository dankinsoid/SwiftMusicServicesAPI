//
//  SPNextRequest.swift
//  MusicImport
//
//  Created by Daniil on 25.07.2020.
//  Copyright © 2020 Данил Войдилов. All rights reserved.
//

import SwiftHttp

extension Spotify.API {

    public func next<Output: Decodable>(
        url: HttpUrl
    ) async throws -> Output {
        try await decodableRequest(
            executor: client.dataTask,
            url: url,
            method: .get,
            headers: headers()
        )
    }
}
