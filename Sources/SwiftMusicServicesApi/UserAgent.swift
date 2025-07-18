import SwiftAPIClient

public let defaultUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_7_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.4 Mobile/15E148 Safari/604.1"

extension SecureCacheServiceKey {

		public static let userAgent = SecureCacheServiceKey("UserAgent")
		public static let cookies = SecureCacheServiceKey("Cookies")
}

extension APIClient.Configs {

		public var minimal: Bool {
				get { self[\.minimal] ?? false }
				set { self[\.minimal] = newValue }
		}
}

public extension APIClient {

		var xmlHttpRequest: APIClient {
				header(.xRequestedWith, "XMLHttpRequest")
		}
}

public extension HTTPField.Name {

		static let xRequestedWith: HTTPField.Name = HTTPField.Name("X-Requested-With")!
}
