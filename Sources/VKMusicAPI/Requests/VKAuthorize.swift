import Foundation
import SwiftAPIClient

public extension VK.API {
	func authorize(_ parameters: VKAuthorizeParameters) async throws {
		try await client.url("https://login.vk.com")
			.query(
				VKAuthorizeAllParameters(
					ip_h: parameters.pre.ip,
					lg_h: parameters.pre.lg,
					email: parameters.login,
					pass: parameters.password
				)
			)
			.configs(\.minimal, true)
			.post()
	}

	func authorizeAndGetUser(_ parameters: VKAuthorizeParameters) async throws -> VKUser {
		try await authorize(parameters)
		if case let .authorized(user) = try await checkAuthorize() {
			return user
		} else {
			throw InvalidUserStatus()
		}
	}

	func checkAuthorize() async throws -> VKAuthorizationState {
		try await client("account")
			.xmlHttpRequest
			.call(.http, as: .htmlInitable)
	}
}

private struct InvalidUserStatus: Error {}
