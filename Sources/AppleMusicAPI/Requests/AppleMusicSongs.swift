//
//  Songs.swift
//  MusicImport
//
//  Created by crypto_user on 27.02.2020.
//  Copyright © 2020 Данил Войдилов. All rights reserved.
//

import Foundation
import SwiftHttp
import VDCodable

extension AppleMusic.API {

	public func mySongs(include: [AppleMusic.Objects.Include]? = [.catalog], limit: Int = 100, offset: Int = 0) throws -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		try mySongs(input: MySongsInput(include: include, limit: limit, offset: offset))
	}

	public func mySongs(input: MySongsInput) throws -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		try dataRequest(
				url: baseURL.path("me", "library", "songs").query(from: input)
		)
	}

	public struct MySongsInput: Encodable {
		public var include: [AppleMusic.Objects.Include]?
		public var limit: Int
		public var offset: Int
	}
}

extension AppleMusic.API {
    
	public func songs(storefront: String, ids: [String]) throws -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		try dataRequest(
				url: baseURL.path("catalog", storefront, "songs").query(from: SongsInput(ids: ids))
		)
	}

	public struct SongsInput: Encodable {
		public var ids: [String]
	}
}

extension AppleMusic.API {
	
	public func songsByISRC(storefront: String, isrcs: [String]) throws -> AsyncThrowingStream<[AppleMusic.Objects.Item], Error> {
		try dataRequest(
				url: baseURL.path("catalog", storefront, "songs").query(from: SongsByISRCInput(isrcs: isrcs))
		)
	}

	public struct SongsByISRCInput: Encodable {
		public var isrcs: [String]

		private enum CodingKeys: String, CodingKey, CaseIterable {
			case isrcs = "filter[isrc]"
		}
	}
}
