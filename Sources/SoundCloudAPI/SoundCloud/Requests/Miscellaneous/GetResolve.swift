
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API.Miscellaneous {

	/**
	 Resolves soundcloud.com and on.soundcloud.com URLs to Resource URLs to use with the API.

	 **GET** /resolve
	 */
	func getResolve(url: String, fileID: String = #fileID, line: UInt = #line) async throws {
		try await client
			.path("/resolve")
			.method(.get)
			.query([
				"url": url,
			])
			.auth(enabled: true)
			.call(
				.http,
				as: .void,
				fileID: fileID,
				line: line
			)
	}
}
