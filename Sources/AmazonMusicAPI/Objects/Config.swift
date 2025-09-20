import Foundation
import SwiftAPIClient

public extension Amazon.Objects {

	struct Config: Codable {

		public var accessToken: String
		public var accessTokenExpiresIn: String?
		public var csrf: CSRF
		public var customerId: String?
		public var deviceType: String?
		public var deviceId: String
		public var isProfileCustomer: Bool?
		public var displayLanguage: String?
		public var hostDeafultLocaleId: String?
		public var marketplaceId: String?
		public var musicTerritory: CountryCode?
		public var siteRegion: CountryCode?
		public var version: String?
		public var sessionId: String
		public var ipAddress: String?
		public var montanaCsrf: String?

		public init(
			accessToken: String,
			accessTokenExpiresIn: String? = nil,
			csrf: CSRF,
			customerId: String? = nil,
			deviceType: String? = nil,
			deviceId: String,
			isProfileCustomer: Bool? = nil,
			displayLanguage: String? = nil,
			hostDeafultLocaleId: String? = nil,
			marketplaceId: String? = nil,
			musicTerritory: CountryCode? = nil,
			siteRegion: CountryCode? = nil,
			version: String? = nil,
			sessionId: String,
			ipAddress: String? = nil,
			montanaCsrf: String? = nil
		) {
			self.accessToken = accessToken
			self.accessTokenExpiresIn = accessTokenExpiresIn
			self.customerId = customerId
			self.deviceType = deviceType
			self.deviceId = deviceId
			self.isProfileCustomer = isProfileCustomer
			self.displayLanguage = displayLanguage
			self.hostDeafultLocaleId = hostDeafultLocaleId
			self.marketplaceId = marketplaceId
			self.musicTerritory = musicTerritory
			self.siteRegion = siteRegion
			self.version = version
			self.sessionId = sessionId
			self.ipAddress = ipAddress
			self.csrf = csrf
			self.montanaCsrf = montanaCsrf
		}
	}
}

public struct CSRF: Codable {

	public var token: String
	public var rnd: String
	public var ts: String

	public init(token: String, rnd: String, ts: String) {
		self.token = token
		self.rnd = rnd
		self.ts = ts
	}

	public var json: String {
		"{\"interface\":\"CSRFInterface.v1_0.CSRFHeaderElement\",\"token\":\"\(token)\",\"timestamp\":\"\(ts)\",\"rndNonce\":\"\(rnd)\"}"
	}
}

public struct MetricsContext: Codable {

	public var encodedAffiliateTags: String?
	public var referer: String?
	public var refMarker: String?

	public init(encodedAffiliateTags: String? = nil, referer: String? = nil, refMarker: String? = nil) {
		self.encodedAffiliateTags = encodedAffiliateTags
		self.referer = referer
		self.refMarker = refMarker
	}
}

extension Amazon.Objects.Config: Mockable {
	public static let mock = Amazon.Objects.Config(
		accessToken: "mock_access_token_123",
		accessTokenExpiresIn: "3600",
		csrf: CSRF.mock,
		customerId: "mock_customer_123",
		deviceType: "A3VRME03NAXFUB",
		deviceId: "mock_device_123",
		isProfileCustomer: true,
		displayLanguage: "en_US",
		hostDeafultLocaleId: "en_US",
		marketplaceId: "ATVPDKIKX0DER",
		musicTerritory: .US,
		siteRegion: .US,
		version: "1.0",
		sessionId: "mock_session_123",
		ipAddress: "192.168.1.1",
		montanaCsrf: "mock_montana_csrf"
	)
}

extension CSRF: Mockable {
	public static let mock = CSRF(
		token: "mock_csrf_token",
		rnd: "mock_random_123",
		ts: "1234567890"
	)
}

extension MetricsContext: Mockable {
	public static let mock = MetricsContext(
		encodedAffiliateTags: "mock_affiliate_tags",
		referer: "https://music.amazon.com",
		refMarker: "mock_ref_marker"
	)
}
