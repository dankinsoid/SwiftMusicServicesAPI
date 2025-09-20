import Foundation
import SwiftAPIClient

public extension Amazon.Music.BrowserAPI {

	func congif() async throws -> Amazon.Objects.Config {
//		if let config, !isConfigExpired { return config }
		let result: Amazon.Objects.Config = try await client("config.json").get()
		config = result
		return result
	}
}
