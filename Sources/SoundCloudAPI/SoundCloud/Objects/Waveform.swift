import Foundation

public extension SoundCloud.Objects {

	struct Waveform: Codable, Equatable {

		public var samples: [Double]

		public init(samples: [Double]) {
			self.samples = samples
		}

		public var width: Int { samples.count }
		public var minHeight: Double { samples.min() ?? 0 }
		public var maxHeight: Double { samples.max() ?? 0 }
	}
}
