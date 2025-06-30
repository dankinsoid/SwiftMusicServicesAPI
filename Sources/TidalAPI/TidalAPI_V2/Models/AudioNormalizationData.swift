import Foundation
import SwiftAPIClient

public extension TDO {

	/** Track normalization data */
	struct AudioNormalizationData: Codable, Equatable, Sendable {

		public var peakAmplitude: Float?
		public var replayGain: Float?

		public enum CodingKeys: String, CodingKey {

			case peakAmplitude
			case replayGain
		}

		public init(
			peakAmplitude: Float? = nil,
			replayGain: Float? = nil
		) {
			self.peakAmplitude = peakAmplitude
			self.replayGain = replayGain
		}
	}
}
