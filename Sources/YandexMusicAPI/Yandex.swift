import Foundation
import SwiftAPIClient
@_exported import SwiftMusicServicesApi

public typealias YM = Yandex.Music
public typealias YMO = Yandex.Music.Objects

public enum Yandex {
	public enum Music {}
}

public extension Yandex.Music {
	enum Objects {}

	final class API: @unchecked Sendable, APIClientScope {
		public static let clientID = "23cabbbdc6cd418abb4b39c32c41195d"
		public static let clientSecret = "53bc75238f0c4d08a118e51fe9203300"

		public static let baseURL = URL(string: "https://api.music.yandex.net")!
		public static let authURL = URL(string: "https://oauth.yandex.ru")!
		public static let passportURL = URL(string: "https://passport.yandex.com")!
		public static let mobileproxyPassportURL = URL(string: "https://mobileproxy.passport.yandex.net")!

		public static var uuid = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
		public static var ifv = UUID()

		public var client: APIClient {
			get { lock.withReaderLock { _client } }
			set { lock.withWriterLockVoid { _client = newValue } }
		}
		public var token: String? {
			get { lock.withReaderLock { _token } }
			set { lock.withWriterLockVoid { _token = newValue } }
		}

		private var _client: APIClient
		private var _token: String?
		private let lock = ReadWriteLock()

		public init(
			client: APIClient = APIClient(),
			token: String? = nil
		) {
			_token = token
			_client = client
				.url(API.baseURL)
				.bodyDecoder(YandexDecoder())
				.errorDecoder(.yandexMusic)
				.queryEncoder(.urlQuery(arrayEncodingStrategy: .commaSeparator, nestedEncodingStrategy: .json))
				.header(.userAgent, "Maple/750 (iPhone; iOS 18.6.2; Scale/3.0)")
				.header("Ya-Client-User-Agent", "Maple/750 (iPhone; iOS 18.6.2; Scale/3.0)")
				.header("X-Yandex-Music-Client", "YandexMusic/750.194214")
				.httpResponseValidator(.statusCode)
				.auth(enabled: true)

			_client = self._client.auth(AuthModifier { [weak self] request, _ in
				if let token = self?.token {
					request.headers[.authorization] = "OAuth \(token)"
				}
			})
		}

		public static func url(coverUri: String?) -> URL? {
			guard let uri = coverUri else {
				return nil
			}
			return URL(string: "https://" + uri.replacingOccurrences(of: "%%", with: "200x200"))
		}
	}
}
