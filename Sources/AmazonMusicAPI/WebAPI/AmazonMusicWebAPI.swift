import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public extension Amazon.Music {

	struct WebAPI {

		public static let baseURL = URL(string: "https://api.music.amazon.dev")!
		public let client: APIClient
		public var v1Client: APIClient { client("v1") }

		public init(
			client: APIClient = APIClient()
		) {
			self.client = client
				.url(Self.baseURL)
				.auth(enabled: true)
		}
	}
}
