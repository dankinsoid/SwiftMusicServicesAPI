import Foundation

extension Amazon.Objects {

	public struct Config: Codable {

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
		public var musicTerritory: String?
		public var siteRegion: String?
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
			musicTerritory: String? = nil,
			siteRegion: String? = nil,
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
