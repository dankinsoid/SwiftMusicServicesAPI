import Foundation
import SwiftAPIClient

public struct Streams: Codable, Equatable {

	public var hlsMp3128URL: String?
	public var hlsOpus64URL: String?
	public var httpMp3128URL: String?
	public var previewMp3128URL: String?

	public enum CodingKeys: String, CodingKey {

		case hlsMp3128URL = "hls_mp3_128_url"
		case hlsOpus64URL = "hls_opus_64_url"
		case httpMp3128URL = "http_mp3_128_url"
		case previewMp3128URL = "preview_mp3_128_url"
	}

	public init(
		hlsMp3128URL: String? = nil,
		hlsOpus64URL: String? = nil,
		httpMp3128URL: String? = nil,
		previewMp3128URL: String? = nil
	) {
		self.hlsMp3128URL = hlsMp3128URL
		self.hlsOpus64URL = hlsOpus64URL
		self.httpMp3128URL = httpMp3128URL
		self.previewMp3128URL = previewMp3128URL
	}
}
