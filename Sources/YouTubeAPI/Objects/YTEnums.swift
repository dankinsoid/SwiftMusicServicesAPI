import Foundation

public extension YTO {

	struct PrivacyStatus: LosslessStringConvertible, Codable, Hashable {

		public static let `private` = PrivacyStatus("private")
		public static let `public` = PrivacyStatus("public")
		public static let unlisted = PrivacyStatus("unlisted")

		public var value: String
		public var description: String { value }

		public init(_ value: String) {
			self.value = value
		}

		public init(from decoder: any Decoder) throws {
			try self.init(String(from: decoder))
		}

		public func encode(to encoder: any Encoder) throws {
			try value.encode(to: encoder)
		}
	}

	struct UploadStatus: Hashable, Codable {
		public static let deleted = Self("deleted")
		public static let failed = Self("failed")
		public static let processed = Self("processed")
		public static let rejected = Self("rejected")
		public static let uploaded = Self("uploaded")
		public var value: String

		public init(_ value: String) { self.value = value }
		public init(from decoder: any Decoder) throws { self = try Self(String(from: decoder)) }
		public func encode(to encoder: any Encoder) throws { try value.encode(to: encoder) }
	}

	struct FailureReason: Hashable, Codable {
		public static let codec = Self("codec")
		public static let conversion = Self("conversion")
		public static let emptyFile = Self("emptyFile")
		public static let invalidFile = Self("invalidFile")
		public static let tooSmall = Self("tooSmall")
		public static let uploadAborted = Self("uploadAborted")
		public var value: String

		public init(_ value: String) { self.value = value }
		public init(from decoder: any Decoder) throws { self = try Self(String(from: decoder)) }
		public func encode(to encoder: any Encoder) throws { try value.encode(to: encoder) }
	}

	struct RejectionReason: Hashable, Codable {
		public static let claim = Self("claim")
		public static let copyright = Self("copyright")
		public static let duplicate = Self("duplicate")
		public static let inappropriate = Self("inappropriate")
		public static let legal = Self("legal")
		public static let length = Self("length")
		public static let termsOfUse = Self("termsOfUse")
		public static let trademark = Self("trademark")
		public static let uploaderAccountClosed = Self("uploaderAccountClosed")
		public static let uploaderAccountSuspended = Self("uploaderAccountSuspended")
		public var value: String

		public init(_ value: String) { self.value = value }
		public init(from decoder: any Decoder) throws { self = try Self(String(from: decoder)) }
		public func encode(to encoder: any Encoder) throws { try value.encode(to: encoder) }
	}

	struct License: Hashable, Codable {
		public static let creativeCommon = Self("creativeCommon")
		public static let youtube = Self("youtube")
		public var value: String

		public init(_ value: String) { self.value = value }
		public init(from decoder: any Decoder) throws { self = try Self(String(from: decoder)) }
		public func encode(to encoder: any Encoder) throws { try value.encode(to: encoder) }
	}

	enum FileType: String, Hashable, Codable {
		case archive, audio, document, image, other, project, video
		public init(from decoder: any Decoder) throws {
			self = try Self(rawValue: String(from: decoder)) ?? .other
		}
	}

	enum MyRating: String, Hashable, Codable {
		case dislike, like
	}

	struct VideoCategoryID: Hashable, Codable {
		public static let any = Self("0")
		public static let filmAnimation = Self("1")
		public static let autosVehicles = Self("2")
		public static let music = Self("10")
		public static let petsAnimals = Self("15")
		public static let sports = Self("17")
		public static let shortMovies = Self("18")
		public static let travelEvents = Self("19")
		public static let gaming = Self("20")
		public static let videoblogging = Self("21")
		public static let peopleBlogs = Self("22")
		public static let comedy = Self("23")
		public static let entertainment = Self("24")
		public static let newsPolitics = Self("25")
		public static let howtoStyle = Self("26")
		public static let education = Self("27")
		public static let scienceTechnology = Self("28")
		public static let nonprofitsActivism = Self("29")
		public static let movies = Self("30")
		public static let animeAnimation = Self("31")
		public static let actionAdventure = Self("32")
		public static let classics = Self("33")
		public static let documentary = Self("35")
		public static let drama = Self("36")
		public static let family = Self("37")
		public static let foreign = Self("38")
		public static let horror = Self("39")
		public static let sciFiFantasy = Self("40")
		public static let thriller = Self("41")
		public static let shorts = Self("42")
		public static let shows = Self("43")
		public static let trailers = Self("44")
		public var value: String

		public init(_ value: String) { self.value = value }
		public init(from decoder: any Decoder) throws { self = try Self(String(from: decoder)) }
		public func encode(to encoder: any Encoder) throws { try value.encode(to: encoder) }
	}
}
