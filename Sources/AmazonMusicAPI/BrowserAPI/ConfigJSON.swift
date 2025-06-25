import Foundation
import SwiftAPIClient

extension Amazon.Music.BrwoserAPI {

	public func congif() async throws -> Amazon.Objects.Config {
		let result: Amazon.Objects.Config = try await client("config.json").get()
		self.config = result
		return result
	}
}
