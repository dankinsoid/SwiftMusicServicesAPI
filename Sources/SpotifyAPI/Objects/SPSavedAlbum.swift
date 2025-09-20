import Foundation
import SwiftAPIClient

public struct SPSavedAlbum: Codable {
	/// The date and time the album was saved.
	public var addedAt: Date?
	/// Information about the album.
	public var album: SPAlbum?

	public init(addedAt: Date?, album: SPAlbum?) {
		self.addedAt = addedAt
		self.album = album
	}
}

extension SPSavedAlbum: Mockable {
	public static let mock = SPSavedAlbum(
		addedAt: Date(),
		album: SPAlbum.mock
	)
}
