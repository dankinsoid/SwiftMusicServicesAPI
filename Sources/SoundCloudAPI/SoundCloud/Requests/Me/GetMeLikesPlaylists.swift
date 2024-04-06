
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Me {

	/**
	 Returns a list of favorited or liked playlists of the authenticated user.

	 **GET** /me/likes/playlists
	 */
	func getLikesPlaylists(limit: Int? = nil, linkedPartitioning: Bool? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> OneOf<Playlists, PlaylistsArray> {
		try await client
			.path("/me/likes/playlists")
			.method(.get)
			.query([
				"limit": limit,
				"linked_partitioning": linkedPartitioning,
			])
			.auth(enabled: true)
			.call(
				.http,
				as: .decodable,
				fileID: fileID,
				line: line
			)
	}
}
