import Foundation

public protocol AppleMusicPageResponse {
	associatedtype Item
	var data: [Item] { get }
	var next: String? { get }
}

public extension AppleMusic.Objects {
	struct Response<T: Decodable>: Decodable, AppleMusicPageResponse {
		public init(data: [T], next: String? = nil) {
			self.data = data
			self.next = next
		}

		public var data: [T]
		public var next: String?
	}

	struct Tokens: Codable {
		public var token: String
		public var userToken: String

		public init(token: String, userToken: String) {
			self.token = token
			self.userToken = userToken
		}
	}

	struct Item: Codable {
		public init(attributes: AppleMusic.Objects.Attributes? = nil, relationships: AppleMusic.Objects.Relationships? = nil, id: String, type: AppleMusic.TrackType, href: String? = nil) {
			self.attributes = attributes
			self.relationships = relationships
			self.id = id
			self.type = type
			self.href = href
		}

		public var attributes: Attributes?
		public var relationships: Relationships?
		public var id: String
		public var type: AppleMusic.TrackType
		public var href: String?
	}

	struct ShortItem: Codable {
		public init(id: String, type: AppleMusic.TrackType) {
			self.id = id
			self.type = type
		}

		public var id: String
		public var type: AppleMusic.TrackType
	}

	struct Attributes: Codable {
		public init(name: String, artistName: String? = nil, genreNames: [String]? = nil, albumName: String? = nil, durationInMillis: Int? = nil, releaseDate: String? = nil, dateAdded: String? = nil, playParams: AppleMusic.Objects.PlayParams? = nil, trackNumber: Int? = nil, artwork: AppleMusic.Objects.Artwork? = nil, canEdit: Bool? = nil, hasCatalog: Bool? = nil, description: AppleMusic.Objects.Description? = nil, previews: [AppleMusic.Objects.Url]? = nil, isrc: String? = nil) {
			self.name = name
			self.artistName = artistName
			self.genreNames = genreNames
			self.albumName = albumName
			self.durationInMillis = durationInMillis
			self.releaseDate = releaseDate
			self.dateAdded = dateAdded
			self.playParams = playParams
			self.trackNumber = trackNumber
			self.artwork = artwork
			self.canEdit = canEdit
			self.hasCatalog = hasCatalog
			self.description = description
			self.previews = previews
			self.isrc = isrc
		}

		public var name: String
		public var artistName: String?
		public var genreNames: [String]?
		public var albumName: String?
		public var durationInMillis: Int?
		public var releaseDate: String? // "2015-09-04"Date?
		public var dateAdded: String? // "2016-11-30T00:43:38Z"Date?
		public var playParams: PlayParams?
		public var trackNumber: Int?
		public var artwork: Artwork?
		public var canEdit: Bool?
		public var hasCatalog: Bool?
		public var description: Description?
		public var previews: [Url]?
		public var isrc: String?
	}

	struct Relationships: Codable {
		public init(tracks: AppleMusic.Objects.TracksRelationship? = nil, catalog: AppleMusic.Objects.Response<AppleMusic.Objects.Item>? = nil) {
			self.tracks = tracks
			self.catalog = catalog
		}

		public var tracks: TracksRelationship?
		public var catalog: Response<Item>?
	}

	enum Include: String, Codable, CaseIterable {
		case catalog, tracks
	}

	struct TracksRelationship: Codable {
		public init(data: [AppleMusic.Objects.Item]) {
			self.data = data
		}

		public var data: [Item]
	}

	struct Url: Codable {
		public init(url: String? = nil) {
			self.url = url
		}

		public var url: String?
	}

	struct PlayParams: Codable {
		public init(id: String, isLibrary: Bool? = nil, kind: String? = nil, reporting: Bool? = nil, purchasedId: String? = nil, catalogId: String? = nil) {
			self.id = id
			self.isLibrary = isLibrary
			self.kind = kind
			self.reporting = reporting
			self.purchasedId = purchasedId
			self.catalogId = catalogId
		}

		public var id: String
		public var isLibrary: Bool?
		public var kind: String?
		public var reporting: Bool?
		public var purchasedId: String?
		public var catalogId: String?
	}

	struct Description: Codable {
		public init(standard: String? = nil) {
			self.standard = standard
		}

		public var standard: String?
	}

	struct SongRelationship: Codable {
		public init() {}
	}

	struct Artwork: Codable {
		public init(width: Int? = nil, height: Int? = nil, url: String) {
			self.width = width
			self.height = height
			self.url = url
		}

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
