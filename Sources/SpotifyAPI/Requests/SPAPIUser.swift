//
//  SPAPIUser.swift
//  MusicImport
//
//  Created by Daniil on 25.07.2020.
//  Copyright © 2020 Данил Войдилов. All rights reserved.
//

import SwiftHttp

extension Spotify.API {
    
    ///https://developer.spotify.com/documentation/web-api/reference/playlists/get-a-list-of-current-users-playlists/
    public func me() async throws -> SPUserPrivate {
        try await decodableRequest(executor: client.dataTask, url: baseURL.path("me"), method: .get, headers: headers())
    }
}
