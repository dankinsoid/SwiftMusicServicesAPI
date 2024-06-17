import Foundation
import SwiftAPIClient

public extension Yandex.Music.API {

	enum Import {

		public static var baseURL = URL(string: "https://music.yandex.ru")!
	}
}

public extension Yandex.Music.API {

	func importSearch(_ tracks: [E3U.Line]) async throws -> [YMO.Track] {
		let e3u = E3U(lines: tracks)
		let code = try await importFile(e3u: e3u).importCode
		var result = try await importCode(code)
		while result.status.asEnum == .inProgress {
			try await Task.sleep(nanoseconds: 1_000_000_000)
			result = try await importCode(code)
		}
		guard result.status.asEnum == .done, let tracks = result.tracks else {
			throw UnknownError()
		}
		return tracks
	}
}

public extension Yandex.Music.API {

    func importFile(e3u: E3U) async throws -> ImportFileOutput {
        try await client.url(Yandex.Music.API.Import.baseURL)
            .path("handlers", "import-file.jsx")
            .headers(.contentType(.text(.plain)))
            .header(.connection, "keep-alive")
            .body(E3U.Formatter().convert(e3u))
            .auth(enabled: false)
            .bodyDecoder(YandexDecoder(isAuthorized: false))
            .post()
    }

	struct ImportFileOutput: Codable {
		public let importCode: String
	}
}

public extension Yandex.Music.API {

	func importCode(_ code: String) async throws -> ImportCodeOutput {
		try await client("handlers", "import.jsx")
            .query("code", code)
            .auth(enabled: false)
            .bodyDecoder(YandexDecoder(isAuthorized: false))
            .post()
	}

	struct ImportCodeOutput: Codable {

		public var status: RawEnum<Status>
		public var tracks: [YMO.Track]?

		public enum Status: String, Codable, CaseIterable {
			case done, inProgress = "in-progress", failure, unknown

			public init(from decoder: Decoder) throws {
				self = try Self(rawValue: String(from: decoder)) ?? .unknown
			}
		}
	}
}

public extension Yandex.Music.Objects {

	struct ImportResult<T: Codable>: Codable {

		public let success: Bool
		public var object: T

		public enum CodingKeys: String, CodingKey, CaseIterable {

			case success
		}

		public init(from decoder: Decoder) throws {
			object = try T(from: decoder)
			let container = try decoder.container(keyedBy: CodingKeys.self)
			success = try container.decode(Bool.self, forKey: .success)
		}

		public func encode(to encoder: Encoder) throws {
			try object.encode(to: encoder)
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(success, forKey: .success)
		}
	}
}

public struct UnknownError: Error {}
