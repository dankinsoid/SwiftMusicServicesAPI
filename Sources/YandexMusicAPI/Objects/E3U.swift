import Foundation

public struct E3U {
	public var lines: [Line]

	public struct Line {
		public var duration: Int
		public var artist: String
		public var title: String
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
	}
}
