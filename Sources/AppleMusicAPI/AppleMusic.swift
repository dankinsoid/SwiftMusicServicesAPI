import Foundation
import SwiftAPIClient
@_exported import SwiftMusicServicesApi

public enum AppleMusic {

	public final class API {

		public static var baseURL = URL(string: "https://api.music.apple.com")!
		public private(set) var client = APIClient()

		public init(
			client: APIClient,
			baseURL: URL = API.baseURL,
			storage: SecureCacheService
		) {
			self.client = client
				.url(baseURL)
				.httpResponseValidator(.statusCode)
				.queryEncoder(.urlQuery(arrayEncodingStrategy: .commaSeparator, nestedEncodingStrategy: .brackets))
				.errorDecoder(.decodable(AppleMusic.Objects.ErrorResponse.self))
				.logMaskedHeaders([.musicUserToken])
				.httpClientMiddleware(AppleMusicMiddleware(storage: storage))
		}
	}
}

private struct AppleMusicMiddleware: HTTPClientMiddleware {

	let storage: SecureCacheService

	func execute<T>(
		request: SwiftAPIClient.HTTPRequestComponents,
		configs: SwiftAPIClient.APIClient.Configs,
		next: @escaping Next<T>
	) async throws -> (T, HTTPTypes.HTTPResponse) {
		var request = request
		if !request.headers.contains(.authorization) {
			guard let developerToken = try await storage.load(for: .developerToken) else {
				throw TokenNotFound(name: "developerToken")
			}
			request.headers.append(.authorization(bearerToken: developerToken))
		}
		if !request.headers.contains(.referrerPolicy) {
			request.headers.append(HTTPField(name: .referrerPolicy, value: "origin"))
		}
		if let userToken = try await storage.load(for: .accessToken) {
			request.headers[.musicUserToken] = userToken
		}
		return try await next(request, configs)
	}
}

public extension SecureCacheServiceKey {

	static let developerToken: SecureCacheServiceKey = "developerToken"
	static let userToken: SecureCacheServiceKey = .accessToken
}

public extension HTTPFields.Key {

	static let musicUserToken = HTTPFields.Key("Music-User-Token")!
	static let referrerPolicy = HTTPFields.Key("Referrer-Policy")!
}
