import Foundation
import SwiftAPIClient

public extension TDO {

	struct ArtworkCreateOperationPayloadDataAttributesSourceFile: Codable, Equatable, Sendable {

		public var md5Hash: String
		public var size: Int

		public enum CodingKeys: String, CodingKey {

			case md5Hash
			case size
		}

		public init(
			md5Hash: String,
			size: Int
		) {
			self.md5Hash = md5Hash
			self.size = size
		}
	}
}
