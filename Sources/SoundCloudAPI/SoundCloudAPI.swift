import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public enum SoundCloud {

	public struct API {

		public static let version = "1.0.0"
		public var client: APIClient

		public init(client: APIClient) {
			self.client = client
                .errorDecoder(.decodable(ErrorType.self))
		}
	}
}
