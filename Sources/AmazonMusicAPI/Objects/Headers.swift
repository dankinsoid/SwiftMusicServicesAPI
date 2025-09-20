import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public extension Amazon.Objects {

	struct DefaultBody: Codable {

		private var values: [String: String] = [:]

		public init(
			headers: Headers
		) throws {
			values = [:]
			try set(headers, for: "headers")
		}

		public mutating func removeValue(for key: String) {
			values.removeValue(forKey: key)
		}

		public mutating func set(_ value: some Encodable, for key: String, encoder: ContentEncoder = .json) throws {
			values[key] = try String(data: encoder.encode(value), encoding: .utf8).unwrap(throwing: InvalidUTF8Error())
		}

		public mutating func set(_ value: String, for key: String) {
			values[key] = value
		}

		public init(from decoder: any Decoder) throws {
			values = (try? [String: String](from: decoder)) ?? [:]
		}

		public func encode(to encoder: any Encoder) throws {
			try values.encode(to: encoder)
		}
	}

	struct Headers: Codable {

		public var xAmznAuthentication: String
		public var xAmznCsrf: String

		public var xAmznDeviceModel: String?
		public var xAmznDeviceWidth: String?
		public var xAmznDeviceFamily: String?
		public var xAmznDeviceId: String
		public var xAmznUserAgent: String?
		public var xAmznSessionId: String
		public var xAmznDeviceHeight: String?
		public var xAmznRequestId: String
		public var xAmznDeviceLanguage: String?
		public var xAmznCurrencyOfPreference: String?
		public var xAmznOsVersion: String?
		public var xAmznApplicationVersion: String?
		public var xAmznDeviceTimeZone: String?
		public var xAmznTimestamp: String?
		public var xAmznMusicDomain: String?
		public var xAmznReferer: String?
		public var xAmznAffiliateTags: String?
		public var xAmznRefMarker: String?
		public var xAmznPageUrl: String?
		public var xAmznWeblabIdOverrides: String?
		public var xAmznVideoPlayerToken: String?
		public var xAmznFeatureFlags: String?
		public var xAmznHasProfileId: String?

		public init(
			accessToken: String,
			csrf: CSRF,
			xAmznDeviceModel: String? = "WEBPLAYER",
			xAmznDeviceWidth: String? = "1920",
			xAmznDeviceFamily: String? = "WebPlayer",
			xAmznDeviceId: String,
			xAmznUserAgent: String? = defaultUserAgent,
			xAmznSessionId: String,
			xAmznDeviceHeight: String? = "1080",
			xAmznRequestId: String = UUID().uuidString.lowercased(),
			xAmznDeviceLanguage: String = "en_US",
			xAmznCurrencyOfPreference: String = "USD",
			xAmznOsVersion: String? = "1.0",
			xAmznApplicationVersion: String? = "1.0.6215.0",
			xAmznDeviceTimeZone: String? = "Europe/Berlin",
			xAmznTimestamp: String? = Int(Date().timeIntervalSince1970).description,
			xAmznMusicDomain: String? = "music.amazon.com",
			xAmznReferer: String? = "",
			xAmznAffiliateTags: String? = "",
			xAmznRefMarker: String? = "",
			xAmznPageUrl: String? = "https://music.amazon.com/my/library",
			xAmznWeblabIdOverrides: String? = "",
			xAmznVideoPlayerToken: String? = "",
			xAmznFeatureFlags: String? = nil, // "hd-supported,uhd-supported",
			xAmznHasProfileId: String? = "true"
		) throws {
			let encoder = JSONEncoder()
			xAmznAuthentication = try String(data: encoder.encode(XAmznAuthentication(accessToken: accessToken)), encoding: .utf8)
				.unwrap(throwing: InvalidUTF8Error())
			xAmznCsrf = try String(data: encoder.encode(XAmznCSRF(csrf: csrf)), encoding: .utf8)
				.unwrap(throwing: InvalidUTF8Error())
			self.xAmznDeviceModel = xAmznDeviceModel
			self.xAmznDeviceWidth = xAmznDeviceWidth
			self.xAmznDeviceFamily = xAmznDeviceFamily
			self.xAmznDeviceId = xAmznDeviceId
			self.xAmznUserAgent = xAmznUserAgent
			self.xAmznSessionId = xAmznSessionId
			self.xAmznDeviceHeight = xAmznDeviceHeight
			self.xAmznRequestId = xAmznRequestId
			self.xAmznDeviceLanguage = xAmznDeviceLanguage
			self.xAmznCurrencyOfPreference = xAmznCurrencyOfPreference
			self.xAmznOsVersion = xAmznOsVersion
			self.xAmznApplicationVersion = xAmznApplicationVersion
			self.xAmznDeviceTimeZone = xAmznDeviceTimeZone
			self.xAmznTimestamp = xAmznTimestamp
			self.xAmznMusicDomain = xAmznMusicDomain
			self.xAmznReferer = xAmznReferer
			self.xAmznAffiliateTags = xAmznAffiliateTags
			self.xAmznRefMarker = xAmznRefMarker
			self.xAmznPageUrl = xAmznPageUrl
			self.xAmznWeblabIdOverrides = xAmznWeblabIdOverrides
			self.xAmznVideoPlayerToken = xAmznVideoPlayerToken
			self.xAmznFeatureFlags = xAmznFeatureFlags
			self.xAmznHasProfileId = xAmznHasProfileId
		}

		public enum CodingKeys: String, CodingKey {

			case xAmznAuthentication = "x-amzn-authentication"
			case xAmznDeviceModel = "x-amzn-device-model"
			case xAmznDeviceWidth = "x-amzn-device-width"
			case xAmznDeviceFamily = "x-amzn-device-family"
			case xAmznDeviceId = "x-amzn-device-id"
			case xAmznUserAgent = "x-amzn-user-agent"
			case xAmznSessionId = "x-amzn-session-id"
			case xAmznDeviceHeight = "x-amzn-device-height"
			case xAmznRequestId = "x-amzn-request-id"
			case xAmznDeviceLanguage = "x-amzn-device-language"
			case xAmznCurrencyOfPreference = "x-amzn-currency-of-preference"
			case xAmznOsVersion = "x-amzn-os-version"
			case xAmznApplicationVersion = "x-amzn-application-version"
			case xAmznDeviceTimeZone = "x-amzn-device-time-zone"
			case xAmznTimestamp = "x-amzn-timestamp"
			case xAmznCsrf = "x-amzn-csrf"
			case xAmznMusicDomain = "x-amzn-music-domain"
			case xAmznReferer = "x-amzn-referer"
			case xAmznAffiliateTags = "x-amzn-affiliate-tags"
			case xAmznRefMarker = "x-amzn-ref-marker"
			case xAmznPageUrl = "x-amzn-page-url"
			case xAmznWeblabIdOverrides = "x-amzn-weblab-id-overrides"
			case xAmznVideoPlayerToken = "x-amzn-video-player-token"
			case xAmznFeatureFlags = "x-amzn-feature-flags"
			case xAmznHasProfileId = "x-amzn-has-profile-id"
		}
	}

	struct XAmznAuthentication: Codable {

		public var interface: String
		public var accessToken: String

		public init(
			interface: String = "ClientAuthenticationInterface.v1_0.ClientTokenElement",
			accessToken: String
		) {
			self.interface = interface
			self.accessToken = accessToken
		}
	}

	struct XAmznCSRF: Codable {

		public var interface: String
		public var token: String
		public var timestamp: String
		public var rndNonce: String

		public init(
			interface: String = "CSRFInterface.v1_0.CSRFHeaderElement",
			csrf: CSRF
		) {
			self.interface = interface
			token = csrf.token
			timestamp = csrf.ts
			rndNonce = csrf.rnd
		}
	}
}

private struct InvalidUTF8Error: Error, LocalizedError {

	var description: String { "Invalid UTF-8 encoding." }

	init() {}
}
