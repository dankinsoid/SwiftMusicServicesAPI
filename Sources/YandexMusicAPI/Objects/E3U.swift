import Foundation

public struct E3U {

	@SafeDecodeArray public var lines: [Line]

	public struct Line {

		public var duration: Int
		public var artist: String
		public var title: String

		public init(duration: Int, artist: String, title: String) {
			self.duration = duration
			self.artist = artist
			self.title = title
		}
	}

	public struct Formatter {

		public static let lineEnd = "\n"
		public var fileStart = "#EXTM3U"
		public var lineStart = "#EXTINF:"

		public func convert(_ e3u: E3U) -> Data {
			let lines = ([fileStart] + e3u.lines.map(convert)).joined(separator: Formatter.lineEnd)
			return Data(lines.utf8)
		}

		public func convert(_ line: Line) -> String {
			lineStart + "\(line.duration),\(line.artist) - \(line.title)"
		}

		public init(fileStart: String = "#EXTM3U", lineStart: String = "#EXTINF:") {
			self.fileStart = fileStart
			self.lineStart = lineStart
		}
	}

	public init(lines: [E3U.Line]) {
		self.lines = lines
	}
}
