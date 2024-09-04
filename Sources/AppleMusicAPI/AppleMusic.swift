import Foundation
import SwiftAPIClient
@_exported import SwiftMusicServicesApi

public enum AppleMusic {

	public final class API {

		public static var baseURL = URL(string: "https://api.music.apple.com")!
        public var token: AppleMusic.Objects.Tokens? {
            get { lock.withReaderLock { _token } }
            set { lock.withWriterLockVoid { _token = newValue } }
        }
        private var _token: AppleMusic.Objects.Tokens?
        private let lock = ReadWriteLock()
        private(set) public var client = APIClient()

		public init(
            client: APIClient,
            baseURL: URL = API.baseURL,
            token: AppleMusic.Objects.Tokens? = nil
        ) {
            self._token = token
            self.client = client
                .url(baseURL)
                .httpResponseValidator(.statusCode)
                .queryEncoder(.urlQuery(arrayEncodingStrategy: .commaSeparator, nestedEncodingStrategy: .brackets))
                .errorDecoder(.decodable(AppleMusic.Objects.ErrorResponse.self))
                .modifyRequest { [weak self, token] components, _ in
                    guard let token = self?.token ?? token else {
                        throw TokenNotFound()
                    }
                    if !components.headers.contains(.authorization) {
                        components.headers.append(.authorization(bearerToken: token.token))
                    }
                    if let key = HTTPFields.Key("Referrer-Policy"), !components.headers.contains(key) {
                        components.headers.append(HTTPField(name: key, value: "origin"))
                    }
                }
                .auth(
                    AuthModifier { [weak self, token] in
                        if let token = self?.token ?? token, let key = HTTPFields.Key("Music-User-Token") {
                            $0.headers[key] = token.userToken
                        }
                    }
                )
                .auth(enabled: true)
		}
	}
}
