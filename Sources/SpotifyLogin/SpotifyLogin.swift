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

/// Spotify login object.
public class SpotifyLogin {
	
	/// Shared instance.
	public static let shared = SpotifyLogin()
	
	/// The userName for the current session.
	public var username: String? {
		return session?.username
	}
	
	private var clientID: String?
	private var clientSecret: String?
	private var redirectURL: URL?
	var onLogin: ((Error?) -> Void)?
	
	internal var session: Session? {
		didSet {
			SessionLocalStorage.save(session: session)
		}
	}
	
	internal var urlBuilder: URLBuilder?
	
	private init() {
		session = SessionLocalStorage.loadSession()
	}
	
	// MARK: Interface
	
	/// Configure login object.
	///
	/// - Parameters:
	///   - clientID: App's client id.
	///   - clientSecret: App's client secret.
	///   - redirectURL: App's redirect url.
	public func configure(clientID: String, clientSecret: String, redirectURL: URL) {
		self.clientID = clientID
		self.clientSecret = clientSecret
		self.redirectURL = redirectURL
		self.urlBuilder = URLBuilder(clientID: clientID, clientSecret: clientSecret, redirectURL: redirectURL)
	}
	
	/// Asynchronous call to retrieve the session's auth token. Automatically refreshes if auth token expired.
	///
	/// - Parameter completion: Returns the auth token as a string if available and an optional error.
	public func getAccessToken() async throws -> String {
		try await withCheckedThrowingContinuation { cont in
			getAccessToken {
				if let str = $0 {
					cont.resume(returning: str)
				} else {
					cont.resume(throwing: $1 ?? LoginError.general)
				}
			}
		}
	}
	
	/// Asynchronous call to retrieve the session's auth token. Automatically refreshes if auth token expired.
	///
	/// - Parameter completion: Returns the auth token as a string if available and an optional error.
	public func getAccessToken(completion: @escaping (String?, Error?) -> Void) {
		// If the login object is not fully configured, return an error
		guard redirectURL != nil, let clientID = clientID, let clientSecret = clientSecret else {
			completion(nil, LoginError.configurationMissing)
			return
		}
		// If there is no session, return an error
		guard let session = session else {
			completion(nil, LoginError.noSession)
			return
		}
		// If session is valid return access token, otherwsie refresh
		if session.isValid() {
			completion(session.accessToken, nil)
			return
		} else {
			Networking.renewSession(
				session: session,
				clientID: clientID,
				clientSecret: clientSecret
			) { [weak self] session, error in
				if let session = session, error == nil {
					self?.session = session
					completion(session.accessToken, nil)
				} else {
					completion(nil, error)
				}
			}
		}
	}
	
	/// Log out of current session.
	public func logout() {
		SessionLocalStorage.removeSession()
		session = nil
	}
	
	/// Process URL and attempts to create a session.
	///
	/// - Parameters:
	///   - url: url to handle.
	///   - completion: Returns an optional error or nil if successful.
	/// - Returns: Whether or not the URL was handled.
	public func applicationOpenURL(_ url: URL, completion block: @escaping (Error?) -> Void = { _ in }) -> Bool {
		let completion: (Error?) -> Void = {[weak self] in
			block($0)
			self?.onLogin?($0)
			self?.onLogin = nil
		}
		guard let urlBuilder = urlBuilder,
					let redirectURL = redirectURL,
					let clientID = clientID,
					let clientSecret = clientSecret else {
			DispatchQueue.main.async {
				completion(LoginError.configurationMissing)
			}
			return false
		}
		
		guard urlBuilder.canHandleURL(url) else {
			DispatchQueue.main.async {
				completion(LoginError.invalidUrl)
			}
			return false
		}
		
		let parsedURL = urlBuilder.parse(url: url)
		if let code = parsedURL.code, !parsedURL.error {
			Networking.createSession(
				code: code,
				redirectURL: redirectURL,
				clientID: clientID,
				clientSecret: clientSecret
			) { [weak self] session, error in
				DispatchQueue.main.async {
					if error == nil {
						self?.session = session
						NotificationCenter.default.post(name: .SpotifyLoginSuccessful, object: nil)
					}
					completion(error)
				}
			}
		} else {
			DispatchQueue.main.async {
				NotificationCenter.default.post(name: .SpotifyLoginSuccessful, object: nil)
				completion(LoginError.invalidUrl)
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
}

public extension Notification.Name {
	/// A Notification that is emitted by SpotifyLogin after a successful login. Can be used to update the UI.
	static let SpotifyLoginSuccessful = Notification.Name("SpotifyLoginSuccessful")
}
