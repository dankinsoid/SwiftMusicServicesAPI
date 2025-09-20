import Foundation
import SwiftAPIClient
@_exported import SwiftMusicServicesApi

public extension SoundCloud {

	final class OAuth2 {

		public static let desktopWebRedirectURI = "https://soundcloud.com/signin/callback"
		public static let mobileWebRedirectURI = "https://m.soundcloud.com/signin/callback"

		package var onLogin: ((Result<SCO.OAuthToken, Swift.Error>) -> Void)?
		public let clientID: String
		public let redirectURI: String
		public var codeVerifier: String? {
			get { lock.withReaderLock { _codeVerifier } }
			set { lock.withWriterLockVoid { _codeVerifier = newValue } }
		}

		private var _codeVerifier: String?
		private let lock = ReadWriteLock()

		public let client: APIClient

		/// - Parameters:
		///   - clientID: The client ID for your application. You can find this value in the API Console Credentials [page](https://console.developers.google.com/apis/credentials).
		///   - clientSecret: The client secret obtained from the API Console Credentials [page](https://console.developers.google.com/apis/credentials).
		///   - redirectURI: Determines where the API server redirects the user after the user completes the authorization flow.
		///   The value must exactly match one of the authorized redirect URIs for the OAuth 2.0 client, which you configured in your client's API Console [Credentials page](https://console.developers.google.com/apis/credentials).
		///   If this value doesn't match an authorized redirect URI for the provided client_id you will get a redirect_uri_mismatch error.
		///   Note that the http or https scheme, case, and trailing slash ('/') must all match.
		public init(
			client: APIClient = APIClient(),
			clientID: String = SoundCloud.API.desktopWebClientID,
			redirectURI: String = OAuth2.desktopWebRedirectURI
		) {
			self.client = client.url("https://secure.soundcloud.com/oauth")
				.bodyEncoder(.formURL(keyEncodingStrategy: .convertToSnakeCase))
				.bodyDecoder(.json(keyDecodingStrategy: .convertFromSnakeCase))
				.queryEncoder(.urlQuery(keyEncodingStrategy: .convertToSnakeCase))
				.errorDecoder(.decodable(SCO.Error.self))
				.httpResponseValidator(.statusCode)
				.configs {
					$0.loggingComponents.remove(.body)
					$0.loggingComponents.remove(.cURL)
				}
				.finalizeRequest { req, _ in
					req = req.query("client_id", clientID)
				}
			self.clientID = clientID
			self.redirectURI = redirectURI
		}

		public func authURL(
			deviceId: String? = nil,
			responseType: String = "code",
			state: String? = nil,
			codeChallengeMethod: CodeChallengeMethod? = .S256
		) -> URL? {
			let codeChallenge: String?
			let codeVerifier: String?
			if let codeChallengeMethod, let (verifier, challenge) = generateCodeChallenge(method: codeChallengeMethod) {
				codeVerifier = verifier
				codeChallenge = challenge
			} else {
				codeVerifier = nil
				codeChallenge = nil
			}
			return authURL(
				responseType: responseType,
				state: state,
				codeChallenge: codeChallenge,
				codeVerifier: codeVerifier,
				codeChallengeMethod: codeChallengeMethod
			)
		}

		public func authURL(
			deviceId: String? = nil,
			responseType: String = "code",
			state: String? = nil,
			codeChallenge: String?,
			codeVerifier: String?,
			codeChallengeMethod: CodeChallengeMethod? = .S256
		) -> URL? {
			self.codeVerifier = codeVerifier
			let deviceID = deviceId ?? (0 ..< 4).map { _ in String(Int.random(in: 100_000 ..< 999_999)) }.joined(separator: "-")
			return APIClient(string: "https://secure.soundcloud.com/web-auth")
				.query(SCO.AuthorizeRequest(
					clientId: clientID,
					responseType: responseType,
					redirectUri: redirectURI,
					state: state,
					codeChallenge: codeChallenge,
					codeChallengeMethod: codeChallengeMethod?.rawValue
				))
				.query([
					"deviceId": deviceID,
					"origin": "https://m.soundcloud.com",
					"theme": "prefers-color-scheme",
					"uiEvo": true,
					"appId": 65097,
					"tracking": "local",
				])
				.queryEncoder(.urlQuery(keyEncodingStrategy: .convertToSnakeCase))
				.url
		}

		/// - Returns: An auth code.
		/// - Throws: ``SCO.Auth.Error``
		public func codeFrom(redirected url: String) throws -> String? {
			guard let components = URLComponents(string: url) else { return nil }
			let items = components.queryItems ?? []
			if let value = items.first(where: { $0.name == "code" })?.value {
				return value
			} else if let error = items.first(where: { $0.name == "error" })?.value {
				throw AnyError(error)
			} else {
				return nil
			}
		}

		@discardableResult
		public func token(
			code: String,
			codeVerifier: String? = nil,
			cache: SecureCacheService
		) async throws -> SCO.OAuthToken {
			do {
				let result: SCO.OAuthToken = try await client("token")
					.body(
						SCO.TokenRequest(
							clientId: clientID,
							code: code,
							codeVerifier: codeVerifier ?? self.codeVerifier,
							grantType: "authorization_code",
							redirectUri: redirectURI
						)
					)
					.query("grant_type", "authorization_code")
					.post()
				self.codeVerifier = nil
				try? await cache.save(result.accessToken, for: .accessToken)
				if let refreshToken = result.refreshToken {
					try? await cache.save(refreshToken, for: .refreshToken)
				}
				if let expiresIn = result.expiresIn {
					try? await cache.save(Date(timeIntervalSinceNow: expiresIn), for: .expiryDate)
				}
				onLogin?(.success(result))
				return result
			} catch {
				onLogin?(.failure(error))
				throw error
			}
		}

		public func refreshToken(
			cache: SecureCacheService
		) async throws -> SCO.OAuthToken {
			let result = try await client("token")
				.body([
					"grantType": "refresh_token",
					"clientId": clientID,
					"refreshToken": cache.load(for: .refreshToken),
					"redirectUri": redirectURI,
				])
				.post
				.call(.http, as: .decodable(SCO.OAuthToken.self))
			try? await cache.save(result.accessToken, for: .accessToken)
			if let refreshToken = result.refreshToken {
				try? await cache.save(refreshToken, for: .refreshToken)
			}
			if let expiresIn = result.expiresIn {
				try? await cache.save(Date(timeIntervalSinceNow: expiresIn), for: .expiryDate)
			}
			return result
		}
	}
}
