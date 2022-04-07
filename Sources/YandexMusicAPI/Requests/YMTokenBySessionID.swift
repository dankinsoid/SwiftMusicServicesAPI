//
//  YMTokenBySessionID.swift
//  MusicImport
//
//  Created by Данил Войдилов on 21.03.2022.
//  Copyright © 2022 Данил Войдилов. All rights reserved.
//

import Foundation
import SwiftHttp
import VDCodable

extension Yandex.Music.API {
	
	public func tokenBySessionID(cookies: [(String, String)], track_id: String?, info: TokenBySessionIDQuery) async throws -> Yandex.Music.API.TokenOutput {
		let cookies = cookies.map({ "\($0.0)=\($0.1)" }).joined(separator: "; ")
		let set = CharacterSet(charactersIn: "=\"#%/<>?@\\^`{|};: ").inverted
		let input = TokenBySessionIDInput(track_id: track_id, cookies: cookies.addingPercentEncoding(withAllowedCharacters: set) ?? cookies)

		let encoder = URLQueryEncoder(keyEncodingStrategy: .convertToSnakeCase)
		encoder.nestedEncodingStrategy = .json
		encoder.trimmingSquareBrackets = true

		return try await request(
				url: Yandex.Music.API.mobileproxyPassportURL.path("1", "bundle", "oauth", "token_by_sessionid").query(from: info, encoder: encoder),
				method: .post,
				auth: false,
				body: Data(encoder.encodePath(input).utf8),
				headers: [
					.key(.contentType): "application/x-www-form-urlencoded",
					.custom("Cookie"): cookies,
					.custom("Ya-Client-Cookie"): cookies,
					.custom("Ya-Client-Host"): cookies,
					.custom("Host"): "mobileproxy.passport.yandex.net"
				]
		)
	}

	public struct TokenBySessionIDQuery: Codable {
		public var app_id = "ru.yandex.mobile.music"
		public var uuid = Yandex.Music.API.uuid
		public var app_version_name	= "5.70"
		public var ifv = YM.API.ifv
		public var am_version_name =	"6.6.1"
//			public var deviceidhash	= "4692844376287701807"
		public var manufacturer	= "Apple"
		public var deviceid: String
		public var device_name: String
		public var device_id: String
		public var app_platform = "ios"
		public var model = "iPhone14,5"

		public init(
				app_id: String = "ru.yandex.mobile.music",
				uuid: String = Yandex.Music.API.uuid,
				app_version_name: String = "5.70",
			  ifv: UUID = YM.API.ifv,
				am_version_name: String =	"6.6.1",
//			public var deviceidhash	= "4692844376287701807"
				manufacturer: String = "Apple",
				deviceid: String,// "FBF6FE07-938F-43D6-8EC1-301A1FFD2D94"
				device_name: String,
				device_id: String,// "FBF6FE07-938F-43D6-8EC1-301A1FFD2D94"
				app_platform: String = "ios",
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

	public struct TokenBySessionIDInput: Codable {
		public var client_id = "c0ebe342af7d48fbbbfcf2d2eedb8f9e" //YM.API.clientID
		public var client_secret = "ad0a908f0aa341a182a37ecd75bc319e" //YM.API.clientSecret
		public var grant_type: YM.API.GrantType = .sessionid
		public var host = "yandex.com"
		public var track_id: String?
		public var cookies: String
	}
}
