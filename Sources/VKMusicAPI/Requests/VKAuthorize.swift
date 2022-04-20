//
// Created by Данил Войдилов on 08.04.2022.
//

import Foundation
import SwiftHttp

extension VK.API {

	public func authorize(_ parameters: VKAuthorizeParameters) async throws {
		let input = VKAuthorizeAllParameters(ip_h: parameters.pre.ip, lg_h: parameters.pre.lg, email: parameters.login, pass: parameters.password)
		_ = try await rawRequest(
				executor: client.dataTask,
				url: HttpUrl(host: "login.vk.com").query(from: input),
				method: .post,
				headers: headers(minimum: true)
		)
	}

	public func authorizeAndGetUser(_ parameters: VKAuthorizeParameters) async throws -> VKUser {
		try await authorize(parameters)
		if case .authorized(let user) = try await checkAuthorize() {
			return user
		} else {
			throw InvalidUserStatus()
		}
	}

	public func checkAuthorize() async throws -> VKAuthorizationState {
		try await request(
				url: baseURL,
				method: .get,
				minimum: true
		)
	}
}

private struct InvalidUserStatus: Error {}
