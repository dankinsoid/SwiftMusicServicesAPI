import Foundation
import SwiftHttp

public extension VK.API {
	func authorize(_ parameters: VKAuthorizeParameters) async throws {
		let extractedExpr = VKAuthorizeAllParameters(ip_h: parameters.pre.ip, lg_h: parameters.pre.lg, email: parameters.login, pass: parameters.password)
		let input = extractedExpr
		try await request(
			url: HttpUrl(host: "login.vk.com").query(from: input),
			method: .post,
			headers: headers(minimum: true)
		) { _ in () }
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
		try await htmlRequest(
			url: baseURL.path("feed"),
			method: .get,
			minimum: false
		)
	}
}

private struct InvalidUserStatus: Error {}
