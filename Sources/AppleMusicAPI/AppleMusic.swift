import Foundation
import SwiftAPIClient
@_exported import SwiftMusicServicesApi

public enum AppleMusic {

	public final class API {

		public static var baseURL = URL(string: "https://api.music.apple.com")!
		public var token: AppleMusic.Objects.Tokens?
		public var userToken: String?
        private let _client: APIClient

        public var client: APIClient {
            _client
                .auth(
                    AuthModifier { [token] in
                        if let token {
                            $0.headers.append(.authorization(bearerToken: token.token))
                            if let key = HTTPFields.Key("Music-User-Token") {
                                $0.headers[key] = token.userToken
                            }
                        }
                    }
                )
        }

		public init(
            client: APIClient,
            baseURL: URL = API.baseURL,
            token: AppleMusic.Objects.Tokens? = nil,
            userToken: String? = nil
        ) {
			_client = client
                .url(baseURL)
                .httpResponseValidator(.statusCode)
                .queryEncoder(.urlQuery(arrayEncodingStrategy: .commaSeparator, nestedEncodingStrategy: .brackets))
								.errorDecoder(.decodable(AppleMusic.Objects.ErrorObject.self))
			self.token = token
		}
	}
}
