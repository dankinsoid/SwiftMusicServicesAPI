import Foundation
import SwiftAPIClient

public extension TDO {

	/** Artwork source file */
	struct ArtworkSourceFile: Codable, Equatable, Sendable {

		/** MD5 hash of file to be uploaded */
		public var md5Hash: String
		/** File size of the artwork in bytes */
		public var size: Int
		public var status: FileStatus
		public var uploadLink: FileUploadLink

		public enum CodingKeys: String, CodingKey {

			case md5Hash
			case size
			case status
			case uploadLink
		}

		public init(
			md5Hash: String,
			size: Int,
			status: FileStatus,
			uploadLink: FileUploadLink
		) {
			self.md5Hash = md5Hash
			self.size = size
			self.status = status
			self.uploadLink = uploadLink
		}
	}
}
