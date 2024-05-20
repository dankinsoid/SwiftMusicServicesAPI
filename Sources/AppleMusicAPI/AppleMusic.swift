import Foundation
import SwiftAPIClient
@_exported import SwiftMusicServicesApi

public enum AppleMusic {

	public final class API {

		public static var baseURL = URL(string: "https://api.music.apple.com")!
		public var token: AppleMusic.Objects.Tokens?
        private let _client: APIClient

        public var client: APIClient {
            _client
                .modifyRequest { [token] components, _ in
                    if let token, !components.headers.contains(.authorization) {
                        components.headers.append(.authorization(bearerToken: token.token))
                    }
                    if let key = HTTPFields.Key("Referrer-Policy"), !components.headers.contains(key) {
                        components.headers.append(HTTPField(name: key, value: "origin"))
                    }
                }
                .auth(
                    AuthModifier { [token] in
                        if let token, let key = HTTPFields.Key("Music-User-Token") {
                            $0.headers[key] = token.userToken
                        }
                    }
                )
        }

		public init(
            client: APIClient,
            baseURL: URL = API.baseURL,
            token: AppleMusic.Objects.Tokens? = nil
        ) {
			_client = client
                .url(baseURL)
                .httpResponseValidator(.statusCode)
                .queryEncoder(.urlQuery(arrayEncodingStrategy: .commaSeparator, nestedEncodingStrategy: .brackets))
                .errorDecoder(.decodable(AppleMusic.Objects.ErrorResponse.self))
                .auth(enabled: true)
			self.token = token
		}
	}
}
