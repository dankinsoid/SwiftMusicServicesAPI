import Foundation
import SwiftAPIClient

public extension TDO {

	struct TrackFilesAttributes: Codable, Equatable, Sendable {

		public var albumAudioNormalizationData: AudioNormalizationData?
		/** File's audio format */
		public var format: Format?
		public var trackAudioNormalizationData: AudioNormalizationData?
		/** Track presentation */
		public var trackPresentation: TrackPresentation?
		/** File URL */
		public var url: String?

		public enum CodingKeys: String, CodingKey {

			case albumAudioNormalizationData
			case format
			case trackAudioNormalizationData
			case trackPresentation
			case url
		}

		public init(
			albumAudioNormalizationData: AudioNormalizationData? = nil,
			format: Format? = nil,
			trackAudioNormalizationData: AudioNormalizationData? = nil,
			trackPresentation: TrackPresentation? = nil,
			url: String? = nil
		) {
			self.albumAudioNormalizationData = albumAudioNormalizationData
			self.format = format
			self.trackAudioNormalizationData = trackAudioNormalizationData
			self.trackPresentation = trackPresentation
			self.url = url
		}

		/** File's audio format */
		public enum Format: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case heaacv1 = "HEAACV1"
			case aaclc = "AACLC"
			case flac = "FLAC"
			case flacHires = "FLAC_HIRES"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = Format(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}

		/** Track presentation */
		public enum TrackPresentation: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case full = "FULL"
			case preview = "PREVIEW"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = TrackPresentation(rawValue: rawValue) ?? .undecoded
			}

			public var description: String { rawValue }
		}
	}
}
