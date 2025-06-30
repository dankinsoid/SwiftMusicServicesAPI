import Foundation
import SwiftAPIClient

public extension TDO {

	/** DRM data. Absence implies no DRM. */
	struct DrmData: Codable, Equatable, Sendable {

		public var certificateUrl: String?
		public var drmSystem: DrmSystem?
		public var licenseUrl: String?

		public enum CodingKeys: String, CodingKey {

			case certificateUrl
			case drmSystem
			case licenseUrl
		}

		public init(
			certificateUrl: String? = nil,
			drmSystem: DrmSystem? = nil,
			licenseUrl: String? = nil
		) {
			self.certificateUrl = certificateUrl
			self.drmSystem = drmSystem
			self.licenseUrl = licenseUrl
		}

		/** DRM data. Absence implies no DRM. */
		public enum DrmSystem: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case fairplay = "FAIRPLAY"
			case widevine = "WIDEVINE"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = DrmSystem(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}
	}
}
