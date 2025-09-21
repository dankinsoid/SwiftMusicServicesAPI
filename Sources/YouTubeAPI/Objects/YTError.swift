import Foundation

public extension YTO {

	struct ErrorResponse: Codable, Equatable, LocalizedError, CustomStringConvertible {

		public var error: APIError
		public var description: String { error.message ?? error.errors?.first?.reason ?? "Error" }
		public var errorDescription: String? { description }

		public init(error: APIError) {
			self.error = error
		}

		public struct APIError: Codable, Equatable {
			public var code: Int?
			public var message: String?
			public var errors: [ErrorDetail]?

			public struct ErrorDetail: Codable, Equatable {
				public var message: String?
				public var domain: String?
				public var reason: String?
				public var location: String?
				public var locationType: String?

				public init(message: String? = nil, domain: String? = nil, reason: String? = nil, location: String? = nil, locationType: String? = nil) {
					self.message = message
					self.domain = domain
					self.reason = reason
					self.location = location
					self.locationType = locationType
				}
			}

			public init(code: Int?, message: String?, errors: [ErrorDetail]? = nil) {
				self.code = code
				self.message = message
				self.errors = errors
			}
		}
	}
}
