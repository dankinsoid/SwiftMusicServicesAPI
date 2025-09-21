import Foundation
import SwiftAPIClient

public extension Yandex.Music.API {
	func account() async throws -> YMO.AccountStatus {
		try await client("account", "status").get()
	}
}
