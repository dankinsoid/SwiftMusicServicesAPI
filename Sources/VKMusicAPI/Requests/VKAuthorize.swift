import Foundation
import SwiftHttp

public extension VK.API {
	func authorize(_ parameters: VKAuthorizeParameters) async throws {
		let input = VKAuthorizeAllParameters(ip_h: parameters.pre.ip, lg_h: parameters.pre.lg, email: parameters.login, pass: parameters.password)
		_ = try await rawRequest(
			executor: client.dataTask,
			url: HttpUrl(host: "login.vk.com").query(from: input),
			method: .post,
			headers: headers(minimum: true)
		)
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
		try await request(
            url: baseURL.path("feed"),
			method: .get,
			minimum: false
		)
	}
}

private struct InvalidUserStatus: Error {}
