//
// Created by Данил Войдилов on 12.04.2022.
//

import Foundation

public protocol AppleMusicPageResponse {
	associatedtype Item
	var data: [Item] { get }
	var next: String? { get }
}

extension AppleMusic.Objects {

	public struct Response<T: Decodable>: Decodable, AppleMusicPageResponse {
		public var data: [T]
		public var next: String?
	}

	public struct Tokens: Codable {
		public var token: String
		public var userToken: String
		
		public init(token: String, userToken: String) {
			self.token = token
			self.userToken = userToken
		}
	}

	public struct Item: Codable {
		public var attributes: Attributes?
		public var relationships: Relationships?
		public var id: String
		public var type: AppleMusic.TrackType
		public var href: String?
	}

	public struct ShortItem: Codable {
		public var id: String
		public var type: AppleMusic.TrackType
	}

	public struct Attributes: Codable {
		public var name: String
		public var artistName: String?
		public var genreNames: [String]?
		public var albumName: String?
		public var durationInMillis: Int?
		public var releaseDate: String?			//"2015-09-04"Date?
		public var dateAdded: String?				//"2016-11-30T00:43:38Z"Date?
		public var playParams: PlayParams?
		public var trackNumber: Int?
		public var artwork: Artwork?
		public var canEdit: Bool?
		public var hasCatalog: Bool?
		public var description: Description?
		public var previews: [Url]?
		public var isrc: String?
	}

	public struct Relationships: Codable {
		public var tracks: TracksRelationship?
		public var catalog: Response<Item>?
	}

	public enum Include: String, Codable {
		case catalog, tracks
	}

	public struct TracksRelationship: Codable {
		public var data: [Item]
	}

	public struct Url: Codable {
		public var url: String?
	}

	public struct PlayParams: Codable {
		public var id: String
		public var isLibrary: Bool?
		public var kind: String?
		public var reporting: Bool?
		public var purchasedId: String?
		public var catalogId: String?
	}

	public struct Description: Codable {
		public var standard: String?
	}

	public struct SongRelationship: Codable {
	}

	public struct Artwork: Codable {
		public var width: Int?
		public var height: Int?
		private var url: String

		public func link(w: Int = 120, h: Int = 120) -> URL {
			URL(string: url
					.replacingOccurrences(of: "{w}", with: "\(w)")
					.replacingOccurrences(of: "{h}", with: "\(h)")
			)!
		}
	}
}

extension AppleMusic.Objects.Response: Encodable where T: Encodable {}
