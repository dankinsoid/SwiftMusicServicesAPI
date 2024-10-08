import Foundation

public protocol AppleMusicPageResponse<Item> {
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

        public enum CodingKeys: CodingKey {
            case data
            case next
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.data = try container.decodeIfPresent(SafeDecodeArray<T>.self, forKey: .data)?.array ?? []
            self.next = try container.decodeIfPresent(String.self, forKey: .next)
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

	struct ErrorResponse: Decodable, LocalizedError, CustomStringConvertible {

		public var errors: [AppleMusic.Objects.ErrorObject]

		public var errorDescription: String? { description }
		public var description: String {
			errors.map { $0.description }.joined(separator: "\n")
		}
		
		public init(errors: [AppleMusic.Objects.ErrorObject]) {
			self.errors = errors
		}
	}
	
	struct ErrorObject: Decodable, LocalizedError, Identifiable, CustomStringConvertible {

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

		public struct Source: Decodable, CustomStringConvertible {
			/// The URI query parameter that caused the error.
			public var parameter: String?
			/// A pointer to the associated entry in the request document.
			public var pointer: String?

			public var description: String {
				[
					parameter.map { "query parameter '\($0)'" },
					pointer.map { "pointer '\($0)'" }
				]
					.compactMap { $0 }.joined(separator: ", ")
			}

			public init(parameter: String? = nil, pointer: String? = nil) {
				self.parameter = parameter
				self.pointer = pointer
			}
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

	struct Relationships: Codable {
		public init(tracks: AppleMusic.Objects.TracksRelationship? = nil, catalog: AppleMusic.Objects.Response<AppleMusic.Objects.Item>? = nil) {
			self.tracks = tracks
			self.catalog = catalog
		}

		public var tracks: TracksRelationship?
		public var catalog: Response<Item>?
	}

	enum Include: String, Codable, CaseIterable {
		case catalog, tracks, unknown

		public init(from decoder: Decoder) throws {
			self = try Self(rawValue: String(from: decoder)) ?? .unknown
		}
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
