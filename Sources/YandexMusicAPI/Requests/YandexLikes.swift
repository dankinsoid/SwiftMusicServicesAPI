//
//  YandexLikes.swift
//  MusicImport
//
//  Created by Данил Войдилов on 29.11.2020.
//  Copyright © 2020 Данил Войдилов. All rights reserved.
//

import Foundation
import SwiftHttp

extension Yandex.Music.API {
	
	public func likedTracks(userID id: Int) async throws -> YMO.LibraryContainer {
		try await request(
				url: baseURL.path("users", "\(id)", "likes", "tracks"),
				method: .get
		)
	}
}
