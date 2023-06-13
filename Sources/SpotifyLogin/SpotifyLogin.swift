// Copyright (c) 2017 Spotify AB.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#if canImport(SafariServices)
	import Foundation
	import SafariServices
    import SpotifyAPI
    import SwiftHttp
    import Logging

	/// Spotify login object.
	public class SpotifyLogin {
        
		/// Shared instance.
		public static let shared = SpotifyLogin()

        private var api: Spotify.API?
		var onLogin: ((Result<SPTokenResponse, LoginError>) -> Void)?
        var urlBuilder: URLBuilder?

		private init() {
		}

		// MARK: Interface

        /// Configure login object.
        ///
        /// - Parameters:
        ///   - api: Spotify.API
        ///   - redirectURL: App's redirect url.
        public func configure(
            api: Spotify.API,
            redirectURL: URL
        ) {
            self.api = api
            urlBuilder = URLBuilder(clientID: api.clientID, clientSecret: api.clientSecret, redirectURL: redirectURL)
        }
        
		/// Configure login object.
		///
		/// - Parameters:
        ///   - client: HttpClient.
		///   - clientID: App's client id.
		///   - clientSecret: App's client secret.
		///   - redirectURL: App's redirect url.
		public func configure(
            client: HttpClient = UrlSessionHttpClient(logLevel: .debug),
            clientID: String,
            clientSecret: String,
            redirectURL: URL
        ) {
            configure(
                api: Spotify.API(
                    client: client,
                    clientID: clientID,
                    clientSecret: clientSecret
                ),
                redirectURL: redirectURL
            )
		}

		/// Process URL and attempts to create a session.
		///
		/// - Parameters:
		///   - url: url to handle.
		///   - completion: Returns an optional error or nil if successful.
		/// - Returns: Whether or not the URL was handled.
		public func applicationOpenURL(_ url: URL, completion block: @escaping (Result<SPTokenResponse, LoginError>) -> Void = { _ in }) -> Bool {
            let onLogin = self.onLogin
			let completion: (Result<SPTokenResponse, LoginError>) -> Void = { result in
                DispatchQueue.main.async {
                    block(result)
                    onLogin?(result)
                    if case .success = result {
                        NotificationCenter.default.post(name: .spotifyLoginSuccessful, object: nil)
                    }
                }
			}
			guard
                let urlBuilder,
                let api
            else {
                completion(.failure(.configurationMissing))
				return false
			}
            
			guard urlBuilder.canHandleURL(url) else {
                completion(.failure(.invalidUrl))
				return false
			}
        
            self.onLogin = nil
			let parsedURL = urlBuilder.parse(url: url)
            guard let code = parsedURL.code, !parsedURL.error else {
                completion(.failure(.invalidUrl))
                return true
            }
            Task {
                do {
                    let result = try await api.accessToken(code: code, redirectURI: urlBuilder.redirectURL.absoluteString)
                    completion(.success(result))
                } catch {
                    if let sperror = error as? SPError {
                        completion(.failure(.spotifyError(sperror)))
                    } else {
                        completion(.failure(.general))
                    }
                }
            }
			return true
		}
	}
#endif

/// Login error
public enum LoginError: Error {
    
	/// Generic error message.
	case general
	/// Spotify Login is not fully configured. Use the configuration function.
	case configurationMissing
	/// There is no valid session. Use the login function.
	case noSession
	/// The url provided to the app can not be handled or parsed.
	case invalidUrl
    case spotifyError(SPError)
}

public extension Notification.Name {
	/// A Notification that is emitted by SpotifyLogin after a successful login. Can be used to update the UI.
	static let spotifyLoginSuccessful = Notification.Name("SpotifyLoginSuccessful")
}
