import Foundation
import SwiftHttp
import VDCodable

public extension Yandex.Music.API {
	func account() async throws -> YMO.AccountStatus {
		try await request(
			url: baseURL.path("account", "status"),
			method: .get
		)
	}
}
