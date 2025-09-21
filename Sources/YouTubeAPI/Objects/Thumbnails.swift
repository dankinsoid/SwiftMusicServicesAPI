import Foundation
import SwiftAPIClient

public extension YouTube.Objects {

	struct Thumbnails: Codable, Hashable {

		public var `default`: Thumbnail?
		public var medium: Thumbnail?
		public var high: Thumbnail?
		public var standard: Thumbnail?
		public var maxres: Thumbnail?

		public init(medium: Thumbnail? = nil, high: Thumbnail? = nil, standard: Thumbnail? = nil, maxres: Thumbnail? = nil) {
			self.medium = medium
			self.high = high
			self.standard = standard
			self.maxres = maxres
		}

		public struct Thumbnail: Codable, Hashable {

			public var url: String
			public var width: Int?
			public var height: Int?

			public init(url: String, width: Int? = nil, height: Int? = nil) {
				self.url = url
				self.width = width
				self.height = height
			}
		}
	}
}

extension YouTube.Objects.Thumbnails.Thumbnail: Mockable {
	public static let mock = YouTube.Objects.Thumbnails.Thumbnail(
		url: "https://example.com/mock_thumbnail.jpg",
		width: 320,
		height: 180
	)
}

extension YouTube.Objects.Thumbnails: Mockable {
	public static let mock = YouTube.Objects.Thumbnails(
		medium: YouTube.Objects.Thumbnails.Thumbnail(
			url: "https://example.com/mock_thumbnail_medium.jpg",
			width: 320,
			height: 180
		),
		high: YouTube.Objects.Thumbnails.Thumbnail(
			url: "https://example.com/mock_thumbnail_high.jpg",
			width: 480,
			height: 360
		),
		standard: YouTube.Objects.Thumbnails.Thumbnail(
			url: "https://example.com/mock_thumbnail_standard.jpg",
			width: 640,
			height: 480
		),
		maxres: YouTube.Objects.Thumbnails.Thumbnail(
			url: "https://example.com/mock_thumbnail_maxres.jpg",
			width: 1280,
			height: 720
		)
	)
}
