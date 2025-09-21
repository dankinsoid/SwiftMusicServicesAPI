import Foundation
import SwiftAPIClient

public extension Amazon.API {

	var user: User {
		User(client: client)
	}
}

public extension Amazon.API {

	struct User {

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

public extension Amazon.Objects {

	struct Profile: Codable {

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
