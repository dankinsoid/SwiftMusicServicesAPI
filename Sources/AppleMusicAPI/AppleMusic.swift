import Foundation
import SwiftAPIClient
@_exported import SwiftMusicServicesApi

public enum AppleMusic {

	public final class API {

		public static var baseURL = URL(string: "https://api.music.apple.com")!
		public var baseURL: URL
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
            client: HTTPClient,
            baseURL: URL = API.baseURL,
            token: AppleMusic.Objects.Tokens? = nil
        ) {
			_client = APIClient(baseURL: baseURL)
                .httpClient(client)
                .rateLimit(errorCodes: [.tooManyRequests, .forbidden])
                .httpResponseValidator(.statusCode)
			self.baseURL = baseURL
			self.token = token
		}
	}
}
