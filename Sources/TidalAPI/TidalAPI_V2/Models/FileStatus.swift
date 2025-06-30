import Foundation
import SwiftAPIClient

public extension TDO {

	/** File status */
	struct FileStatus: Codable, Equatable, Sendable {

		/** Moderation status for file */
		public var moderationFileStatus: ModerationFileStatus
		/** Technical status for file */
		public var technicalFileStatus: TechnicalFileStatus

		public enum CodingKeys: String, CodingKey {

			case moderationFileStatus
			case technicalFileStatus
		}

		public init(
			moderationFileStatus: ModerationFileStatus,
			technicalFileStatus: TechnicalFileStatus
		) {
			self.moderationFileStatus = moderationFileStatus
			self.technicalFileStatus = technicalFileStatus
		}

		/** Moderation status for file */
		public enum ModerationFileStatus: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case notModerated = "NOT_MODERATED"
			case scanning = "SCANNING"
			case flagged = "FLAGGED"
			case takenDown = "TAKEN_DOWN"
			case ok = "OK"
			case error = "ERROR"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = ModerationFileStatus(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}

		/** Technical status for file */
		public enum TechnicalFileStatus: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case uploadRequested = "UPLOAD_REQUESTED"
			case processing = "PROCESSING"
			case failed = "FAILED"
			case ok = "OK"
			case error = "ERROR"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = TechnicalFileStatus(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}
	}
}
