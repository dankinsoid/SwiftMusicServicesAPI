import Foundation
import SwiftAPIClient

extension Amazon {
	
	public struct User {

		public let client: APIClient

		public init(
				client: APIClient
		) {
				self.client = client("user")
		}

		public func profile() async throws -> Amazon.Objects.Profile {
			try await client("profile").get()
		}
	}
}

extension Amazon.Objects {

	public struct Profile: Codable {

		public var user_id: String
		public var email: String?
		public var name: String?

		public init(user_id: String, email: String? = nil, name: String? = nil) {
			self.user_id = user_id
			self.email = email
			self.name = name
		}
	}
}
