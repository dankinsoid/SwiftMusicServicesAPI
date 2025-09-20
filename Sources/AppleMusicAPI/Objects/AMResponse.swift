import Foundation
import SwiftAPIClient

public protocol AppleMusicPageResponse<Item>: Sendable {
	associatedtype Item: Sendable
	var data: [Item] { get }
	var next: String? { get }
}

public extension AppleMusic.Objects {

	struct Response<T: Decodable & Sendable>: Decodable, AppleMusicPageResponse, Sendable {
		public init(data: [T], next: String? = nil) {
			self.data = data
			self.next = next
		}

		public var data: [T]
		public var next: String?

		public enum CodingKeys: CodingKey {
			case data
			case next
		}

		public init(from decoder: any Decoder) throws {
			let container = try decoder.container(keyedBy: CodingKeys.self)
			data = try container.decodeIfPresent(SafeDecodeArray<T>.self, forKey: .data)?.array ?? []
			next = try container.decodeIfPresent(String.self, forKey: .next)
		}
	}

	struct Tokens: Codable {
		public var token: String
		public var userToken: String

		public init(token: String, userToken: String) {
			self.token = token
			self.userToken = userToken
		}
	}

	struct ErrorResponse: Codable, LocalizedError, CustomStringConvertible {

		public var errors: [AppleMusic.Objects.ErrorObject]

		public var errorDescription: String? { description }
		public var description: String {
			errors.map { $0.description }.joined(separator: "\n")
		}

		public init(errors: [AppleMusic.Objects.ErrorObject]) {
			self.errors = errors
		}
	}

	struct ErrorObject: Codable, LocalizedError, Identifiable, CustomStringConvertible {

		/// The code for this error.
		public var code: String
		/// A long, possibly localized, description of the problem.
		public var detail: String?
		/// A unique identifier for this occurrence of the error.
		public var id: String
		/// An object containing references to the source of the error.
		public var source: Source
		/// The HTTP status code for this problem.
		public var status: String
		///  A short, possibly localized, description of the problem.
		public var title: String

		public var errorDescription: String? { description }
		public var description: String {
			"Error: \(title) (\(status))\(detail.map { "\n\($0)" } ?? "")\nsource: \(source)"
		}

		public init(code: String, detail: String? = nil, id: String, source: Source, status: String, title: String) {
			self.code = code
			self.detail = detail
			self.id = id
			self.source = source
			self.status = status
			self.title = title
		}

		public struct Source: Codable, CustomStringConvertible {
			/// The URI query parameter that caused the error.
			public var parameter: String?
			/// A pointer to the associated entry in the request document.
			public var pointer: String?

			public var description: String {
				[
					parameter.map { "query parameter '\($0)'" },
					pointer.map { "pointer '\($0)'" },
				]
				.compactMap { $0 }.joined(separator: ", ")
			}

			public init(parameter: String? = nil, pointer: String? = nil) {
				self.parameter = parameter
				self.pointer = pointer
			}
		}
	}

	struct Item: Codable, Sendable {
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

	struct Attributes: Codable, Sendable {
		public init(name: String? = nil, artistName: String? = nil, genreNames: [String]? = nil, albumName: String? = nil, durationInMillis: Int? = nil, releaseDate: String? = nil, dateAdded: String? = nil, playParams: AppleMusic.Objects.PlayParams? = nil, trackNumber: Int? = nil, artwork: AppleMusic.Objects.Artwork? = nil, canEdit: Bool? = nil, hasCatalog: Bool? = nil, description: AppleMusic.Objects.Description? = nil, previews: [AppleMusic.Objects.Url]? = nil, url: URL? = nil, isrc: String? = nil) {
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
			self.url = url
			self.previews = previews
			self.isrc = isrc
		}

		public var name: String?
		public var artistName: String?
		public var genreNames: [String]?
		public var albumName: String?
		public var durationInMillis: Int?
		public var releaseDate: String? // "2015-09-04"Date?
		public var dateAdded: String? // "2016-11-30T00:43:38Z"Date?
		public var playParams: PlayParams?
		public var trackNumber: Int?
		public var trackCount: Int?
		public var artwork: Artwork?
		public var canEdit: Bool?
		public var hasCatalog: Bool?
		public var description: Description?
		public var previews: [Url]?
		public var url: URL?
		public var isrc: String?
		public var supportedLanguageTags: [String]?
		public var defaultLanguageTag: String?
	}

	struct Relationships: Codable, Sendable {
		public init(tracks: AppleMusic.Objects.TracksRelationship? = nil, catalog: AppleMusic.Objects.Response<AppleMusic.Objects.Item>? = nil) {
			self.tracks = tracks
			self.catalog = catalog
		}

		public var tracks: TracksRelationship?
		public var catalog: Response<Item>?
	}

	enum Include: String, Codable, CaseIterable, Sendable {
		case catalog, tracks, unknown

		public init(from decoder: Decoder) throws {
			self = try Self(rawValue: String(from: decoder)) ?? .unknown
		}
	}

	struct TracksRelationship: Codable, Sendable {
		public init(data: [AppleMusic.Objects.Item]) {
			self.data = data
		}

		public var data: [Item]
	}

	struct Url: Codable, Sendable {
		public init(url: String? = nil) {
			self.url = url
		}

		public var url: String?
	}

	struct PlayParams: Codable, Sendable {
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

	struct Description: Codable, Sendable {
		public init(standard: String? = nil) {
			self.standard = standard
		}

		public var standard: String?
	}

	struct SongRelationship: Codable {
		public init() {}
	}

	struct Artwork: Codable, Sendable {
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

extension AppleMusic.Objects.Response: Mockable where T: Mockable {

	public static var mock: AppleMusic.Objects.Response<T> {
		AppleMusic.Objects.Response(
			data: [T.mock],
			next: nil
		)
	}
}

extension AppleMusic.Objects.Item: Mockable {

	public static var mock: Self {
		Self(
			attributes: AppleMusic.Objects.Attributes.mock,
			relationships: AppleMusic.Objects.Relationships.mock,
			id: "mock_item_id",
			type: .songs,
			href: "https://api.music.apple.com/v1/catalog/us/songs/mock_item_id"
		)
	}
}

extension AppleMusic.Objects.Attributes: Mockable {
	public static let mock = AppleMusic.Objects.Attributes(
		name: "Mock Song",
		artistName: "Mock Artist",
		genreNames: ["Pop", "Rock"],
		albumName: "Mock Album",
		durationInMillis: 180_000,
		releaseDate: "2023-01-01",
		dateAdded: "2023-01-01T00:00:00Z",
		playParams: AppleMusic.Objects.PlayParams.mock,
		trackNumber: 1,
		artwork: AppleMusic.Objects.Artwork.mock,
		canEdit: false,
		hasCatalog: true,
		description: AppleMusic.Objects.Description.mock,
		previews: [AppleMusic.Objects.Url.mock],
		url: URL(string: "https://music.apple.com/mock"),
		isrc: "MOCK1234567890"
	)
}

extension AppleMusic.Objects.Relationships: Mockable {
	public static let mock = AppleMusic.Objects.Relationships(
		tracks: AppleMusic.Objects.TracksRelationship.mock,
		catalog: AppleMusic.Objects.Response<AppleMusic.Objects.Item>.mock
	)
}

extension AppleMusic.Objects.TracksRelationship: Mockable {
	public static let mock = AppleMusic.Objects.TracksRelationship(
		data: [AppleMusic.Objects.Item.mock]
	)
}

extension AppleMusic.Objects.Url: Mockable {
	public static let mock = AppleMusic.Objects.Url(
		url: "https://example.com/preview.m4a"
	)
}

extension AppleMusic.Objects.Description: Mockable {
	public static let mock = AppleMusic.Objects.Description(
		standard: "Mock description"
	)
}

extension AppleMusic.Objects.Artwork: Mockable {
	public static let mock = AppleMusic.Objects.Artwork(
		width: 600,
		height: 600,
		url: "https://is1-ssl.mzstatic.com/image/thumb/{w}x{h}bb.jpg"
	)
}

extension AppleMusic.Objects.PlayParams: Mockable {

	public static let mock = AppleMusic.Objects.PlayParams(
		id: "123456789",
		isLibrary: true,
		kind: "song",
		reporting: false,
		purchasedId: "987654321",
		catalogId: "123456789"
	)
}

extension AppleMusic.Objects.Response: Encodable where T: Encodable {}
