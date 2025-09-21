import Foundation
import SwiftAPIClient

public extension Yandex.Music.API {

	func tokenBySessionID(cookies: [(String, String)], track_id: String?, info: TokenBySessionIDQuery) async throws -> Yandex.Music.API.TokenOutput {
		let cookies = cookies.map { "\($0.0)=\($0.1)" }.joined(separator: "; ")
		let set = CharacterSet(charactersIn: "=\"#%/<>?@\\^`{|};: ").inverted
		let input = TokenBySessionIDInput(track_id: track_id, cookies: cookies.addingPercentEncoding(withAllowedCharacters: set) ?? cookies)
		return try await client
			.url(Yandex.Music.API.mobileproxyPassportURL)
			.path("1", "bundle", "oauth", "token_by_sessionid")
			.query(info)
			.auth(enabled: false)
			.bodyDecoder(YandexDecoder(isAuthorized: false))
			.bodyEncoder(.formURL(keyEncodingStrategy: .convertToSnakeCase, nestedEncodingStrategy: .json))
			.header(.cookie, cookies)
			.header("Ya-Client-Cookie", cookies)
			.header("Ya-Client-Host", cookies)
			.header("Host", "mobileproxy.passport.yandex.net")
			.post()
	}

	struct TokenBySessionIDQuery: Codable {

		public var app_id: String
		public var uuid: String
		public var app_version_name: String
		public var ifv: UUID
		public var am_version_name: String
		public var manufacturer: String
		public var deviceid: UUID
		public var device_name: String
		public var device_id: UUID
		public var app_platform: String
		public var model: String

		public init(
			app_id: String = "ru.yandex.mobile.music",
			uuid: String = Yandex.Music.API.uuid,
			app_version_name: String = "6.16",
			ifv: UUID = YM.API.ifv,
			am_version_name: String = "6.10.1",
			//			public var deviceidhash	= "4692844376287701807"
			manufacturer: String = "Apple",
			deviceid: UUID,
			device_name: String,
			device_id: UUID,
			app_platform: String = "iPhone",
			model: String = "iPhone14,5"
		) {
			self.app_id = app_id
			self.uuid = uuid
			self.app_version_name = app_version_name
			self.ifv = ifv
			self.am_version_name = am_version_name
			self.manufacturer = manufacturer
			self.deviceid = deviceid
			self.device_name = device_name
			self.device_id = device_id
			self.app_platform = app_platform
			self.model = model
		}
	}

	struct TokenBySessionIDInput: Codable {

		public var client_id: String
		public var client_secret: String
		public var grant_type: YM.API.GrantType
		public var host: String
		public var track_id: String?
		public var cookies: String

		public init(client_id: String = "c0ebe342af7d48fbbbfcf2d2eedb8f9e", client_secret: String = "ad0a908f0aa341a182a37ecd75bc319e", grant_type: YM.API.GrantType = .sessionid, host: String = "yandex.com", track_id: String? = nil, cookies: String) {
			self.client_id = client_id
			self.client_secret = client_secret
			self.grant_type = grant_type
			self.host = host
			self.track_id = track_id
			self.cookies = cookies
		}
	}
}
