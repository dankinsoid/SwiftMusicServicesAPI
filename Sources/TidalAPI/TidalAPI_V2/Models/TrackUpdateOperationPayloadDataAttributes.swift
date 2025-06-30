import Foundation
import SwiftAPIClient

public extension TDO {

	struct TrackUpdateOperationPayloadDataAttributes: Codable, Equatable, Sendable {

		/** Access type */
		public var accessType: AccessType?
		public var bpm: Float?
		/** Explicit content */
		public var explicit: Bool?
		public var genreTags: [String]?
		public var key: Key?
		public var keyScale: KeyScale?
		public var title: String?
		public var toneTags: [String]?

		public enum CodingKeys: String, CodingKey {

			case accessType
			case bpm
			case explicit
			case genreTags
			case key
			case keyScale
			case title
			case toneTags
		}

		public init(
			accessType: AccessType? = nil,
			bpm: Float? = nil,
			explicit: Bool? = nil,
			genreTags: [String]? = nil,
			key: Key? = nil,
			keyScale: KeyScale? = nil,
			title: String? = nil,
			toneTags: [String]? = nil
		) {
			self.accessType = accessType
			self.bpm = bpm
			self.explicit = explicit
			self.genreTags = genreTags
			self.key = key
			self.keyScale = keyScale
			self.title = title
			self.toneTags = toneTags
		}

		/** Access type */
		public enum AccessType: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case `public` = "PUBLIC"
			case unlisted = "UNLISTED"
			case `private` = "PRIVATE"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = AccessType(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}

		public enum Key: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case a = "A"
			case ab = "Ab"
			case b = "B"
			case bb = "Bb"
			case c = "C"
			case cSharp = "CSharp"
			case d = "D"
			case e = "E"
			case eb = "Eb"
			case f = "F"
			case fSharp = "FSharp"
			case g = "G"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = Key(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}

		public enum KeyScale: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case major = "MAJOR"
			case minor = "MINOR"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = KeyScale(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}
	}
}
