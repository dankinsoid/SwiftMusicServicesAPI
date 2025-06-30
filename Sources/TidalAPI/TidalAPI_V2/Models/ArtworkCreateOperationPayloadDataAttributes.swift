import Foundation
import SwiftAPIClient

public extension TDO {

	struct ArtworkCreateOperationPayloadDataAttributes: Codable, Equatable, Sendable {

		public var mediaType: MediaType
		public var sourceFile: ArtworkCreateOperationPayloadDataAttributesSourceFile

		public enum CodingKeys: String, CodingKey {

			case mediaType
			case sourceFile
		}

		public init(
			mediaType: MediaType,
			sourceFile: ArtworkCreateOperationPayloadDataAttributesSourceFile
		) {
			self.mediaType = mediaType
			self.sourceFile = sourceFile
		}

		public enum MediaType: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case image = "IMAGE"
			case video = "VIDEO"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = MediaType(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}
	}
}
