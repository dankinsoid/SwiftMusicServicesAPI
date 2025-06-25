import Foundation
import SwiftAPIClient

extension Amazon.Music.BrowserAPI {

	public func congif() async throws -> Amazon.Objects.Config {
//		if let config, !isConfigExpired { return config }
		let result: Amazon.Objects.Config = try await client("config.json").get()
		self.config = result
		return result
	}
}
