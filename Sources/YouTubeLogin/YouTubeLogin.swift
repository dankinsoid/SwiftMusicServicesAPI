#if canImport(UIKit)
	import Logging
	import SafariServices
	import SwiftAPIClient
	import UIKit
	import YouTubeAPI

	public extension YouTube.OAuth2 {

		/// Process URL and attempts to create a session.
		///
		/// - Parameters:
		///   - url: url to handle.
		///   - completion: Returns an optional error or nil if successful.
		/// - Returns: Whether or not the URL was handled.
		func applicationOpenURL(_ url: URL, cache: SecureCacheService = .youTube, completion block: @escaping (Result<YTO.OAuthToken, Swift.Error>) -> Void = { _ in }) -> Bool {
			let onLogin = onLogin
			let completion: (Result<YTO.OAuthToken, Swift.Error>) -> Void = { result in
				DispatchQueue.main.async {
					block(result)
					onLogin?(result)
					if case .success = result {
						NotificationCenter.default.post(name: .youTubeLoginSuccessful, object: nil)
					}
				}
			}

			let code: String
			do {
				code = try codeFrom(redirected: url.absoluteString)
			} catch {
				completion(.failure(error))
				return true
			}

			self.onLogin = nil
			Task { [self] in
				do {
					let result = try await token(code: code, cache: cache)
					completion(.success(result))
				} catch {
					completion(.failure(error))
				}
			}
			return true
		}
	}

	public extension SecureCacheService where Self == KeychainCacheService {

		static var youTube: Self { .keychain(service: "YouTube") }
	}

	public extension Notification.Name {
		/// A Notification that is emitted by SpotifyLogin after a successful login. Can be used to update the UI.
		static let youTubeLoginSuccessful = Notification.Name("YouTubeLoginSuccessful")
	}
#endif
