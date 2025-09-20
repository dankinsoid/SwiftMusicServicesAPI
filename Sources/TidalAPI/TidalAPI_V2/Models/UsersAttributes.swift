import Foundation
import SwiftAPIClient

public extension TDO {

	struct UsersAttributes: Codable, Equatable, Sendable {

		/** ISO 3166-1 alpha-2 country code */
		public var country: CountryCode
		/** user name */
		public var username: String
		/** email address */
		public var email: String?
		/** Is the email verified */
		public var emailVerified: Bool?
		/** Users first name */
		public var firstName: String?
		/** Users last name */
		public var lastName: String?
		/** Users nostr public key */
		public var nostrPublicKey: String?

		public enum CodingKeys: String, CodingKey {

			case country
			case username
			case email
			case emailVerified
			case firstName
			case lastName
			case nostrPublicKey
		}

		public init(
			country: CountryCode,
			username: String,
			email: String? = nil,
			emailVerified: Bool? = nil,
			firstName: String? = nil,
			lastName: String? = nil,
			nostrPublicKey: String? = nil
		) {
			self.country = country
			self.username = username
			self.email = email
			self.emailVerified = emailVerified
			self.firstName = firstName
			self.lastName = lastName
			self.nostrPublicKey = nostrPublicKey
		}
	}
}
