import SwiftAPIClient
import VDCodable

extension Amazon.Music.BrowserAPI {

	public func showHome() async throws -> JSON {
		try await musicClient("showHome").post()
	}
}
