import Foundation
import SwiftHttp
import VDCodable

public extension Yandex.Music.API {
	enum Import {
		public static var baseURL = HttpUrl(host: "music.yandex.ru")
	}
}

public extension Yandex.Music.API {
	func importSearch(_ tracks: [E3U.Line]) async throws -> [YMO.Track] {
		let e3u = E3U(lines: tracks)
		let code = try await importFile(e3u: e3u).importCode
		var result = try await importCode(code)
		while result.status.asEnum == .inProgress {
			sleep(2)
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
		let response = try await encodableRequest(
			executor: client.dataTask,
			url: Yandex.Music.API.Import.baseURL.path("handlers").resource("import-file.jsx"),
			method: .post,
			headers: [
				.contentType: "text/plain",
				"Connection": "keep-alive",
			],
			body: E3U.Formatter().convert(e3u)
		)
		return try VDJSONDecoder().decode(ImportFileOutput.self, from: response.data)
	}

	struct ImportFileOutput: Codable {
		public let importCode: String
	}
}

public extension Yandex.Music.API {
	func importCode(_ code: String) async throws -> ImportCodeOutput {
		let response = try await rawRequest(
			executor: client.dataTask,
			url: Yandex.Music.API.Import.baseURL
				.path("handlers").resource("import.jsx")
				.query("code", code),
			method: .post
		)
		return try VDJSONDecoder().decode(ImportCodeOutput.self, from: response.data)
	}

	struct ImportCodeOutput: Codable {
		public var status: RawEnum<Status>
		public var tracks: [YMO.Track]?

		public enum Status: String, Codable, CaseIterable {
			case done, inProgress = "in-progress", failure
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
