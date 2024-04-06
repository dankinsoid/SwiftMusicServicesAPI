
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Me {

	/**
	 Returns a list of recent tracks from users followed by the authenticated user.

	 **GET** /me/followings/tracks
	 */
	func getFollowingsTracks(access: [Access]? = nil, limit: Int? = nil, offset: Int? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TracksList {
		try await client
			.path("/me/followings/tracks")
			.method(.get)
			.query([
				"access": access,
				"limit": limit,
				"offset": offset,
			])
			.auth(enabled: true)
			.call(
				.http,
				as: .decodable,
				fileID: fileID,
				line: line
			)
	}

	enum GetMeFollowingsTracks {}
}
