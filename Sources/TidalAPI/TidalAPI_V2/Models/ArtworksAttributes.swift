import Foundation
import SwiftAPIClient

public extension TDO {

	struct ArtworksAttributes: Codable, Equatable, Sendable {

		/** Artwork files */
		public var files: [ArtworkFile]
		/** Media type of artwork files */
		public var mediaType: MediaType
		public var sourceFile: ArtworkSourceFile?

		public enum CodingKeys: String, CodingKey {

			case files
			case mediaType
			case sourceFile
		}

		public init(
			files: [ArtworkFile],
			mediaType: MediaType,
			sourceFile: ArtworkSourceFile? = nil
		) {
			self.files = files
			self.mediaType = mediaType
			self.sourceFile = sourceFile
		}

		/** Media type of artwork files */
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
