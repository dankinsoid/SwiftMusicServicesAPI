import Foundation
import SwiftAPIClient

public extension Yandex.Music.API {

	func settings() async throws -> YMO.Settings {
		try await client("account", "settings").get()
	}
}
