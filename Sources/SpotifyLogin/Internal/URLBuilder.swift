import Foundation
import SpotifyAPI
import SwiftMusicServicesApi

final class URLBuilder {

	let clientID: String
	let clientSecret: String
	let redirectURL: URL

	// MARK: Lifecycle

	init(clientID: String, clientSecret: String, redirectURL: URL) {
		self.clientID = clientID
		self.clientSecret = clientSecret
		self.redirectURL = redirectURL
	}

	// MARK: URL functions

	func authenticationURL(type: AuthenticationURLType, scopes: [Scope]) -> URL? {

		let endpoint = type.rawValue
		let scopeStrings = scopes.map { $0.rawValue }

		var params = [
			"client_id": clientID,
			"redirect_uri": redirectURL.absoluteString,
			"response_type": "code",
			"show_dialog": "true",
			"nosignup": "true",
			"nolinks": "true",
			"utm_source": Constants.AuthUTMSourceQueryValue,
			"utm_medium": Constants.AuthUTMMediumCampaignQueryValue,
			"utm_campaign": Constants.AuthUTMMediumCampaignQueryValue,
		]

		if scopeStrings.count > 0 {
			params["scope"] = scopeStrings.joined(separator: " ")
		}

		let loginPageURLString = "\(endpoint)authorize?\(String.query(params: params))"
		return URL(string: loginPageURLString)
	}

	func parse(url: URL) -> (code: String?, error: Bool) {
		var code: String?
		var error = false
		let components = URLComponents(string: url.absoluteString)

		if let queryItems = components?.queryItems {
			for query in queryItems {
				if query.name == "code" {
					code = query.value
				} else if query.name == "error" {
					error = true
				}
			}
		}
		if code == nil {
			error = true
		}
		return (code: code, error: error)
	}

	func canHandleURL(_ url: URL) -> Bool {
		let redirectURLString = redirectURL.absoluteString
		return url.absoluteString.hasPrefix(redirectURLString)
	}
}

enum AuthenticationURLType: String, CaseIterable {

	case app = "spotify-action://"
	case web = "https://accounts.spotify.com/"
}
