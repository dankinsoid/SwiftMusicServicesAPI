import Foundation
import SwiftAPIClient

public extension TDO {

	struct TrackManifestsAttributes: Codable, Equatable, Sendable {

		public var albumAudioNormalizationData: AudioNormalizationData?
		public var drmData: DrmData?
		/** Formats present in manifest */
		public var formats: [Formats]?
		/** Unique manifest hash */
		public var hash: String?
		public var trackAudioNormalizationData: AudioNormalizationData?
		/** Track presentation */
		public var trackPresentation: TrackPresentation?
		/** Manifest URI */
		public var uri: String?

		public enum CodingKeys: String, CodingKey {

			case albumAudioNormalizationData
			case drmData
			case formats
			case hash
			case trackAudioNormalizationData
			case trackPresentation
			case uri
		}

		public init(
			albumAudioNormalizationData: AudioNormalizationData? = nil,
			drmData: DrmData? = nil,
			formats: [Formats]? = nil,
			hash: String? = nil,
			trackAudioNormalizationData: AudioNormalizationData? = nil,
			trackPresentation: TrackPresentation? = nil,
			uri: String? = nil
		) {
			self.albumAudioNormalizationData = albumAudioNormalizationData
			self.drmData = drmData
			self.formats = formats
			self.hash = hash
			self.trackAudioNormalizationData = trackAudioNormalizationData
			self.trackPresentation = trackPresentation
			self.uri = uri
		}

		/** Formats present in manifest */
		public enum Formats: String, Codable, Equatable, CaseIterable, CustomStringConvertible, Sendable {
			case heaacv1 = "HEAACV1"
			case aaclc = "AACLC"
			case flac = "FLAC"
			case flacHires = "FLAC_HIRES"
			case undecoded

			public init(from decoder: Decoder) throws {
				let container = try decoder.singleValueContainer()
				let rawValue = try container.decode(String.self)
				self = Formats(rawValue: rawValue) ?? .undecoded
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
