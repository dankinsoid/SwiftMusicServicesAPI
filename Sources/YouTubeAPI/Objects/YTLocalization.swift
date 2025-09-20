import Foundation
import SwiftAPIClient

public extension YTO {

	struct Localization: Codable, Equatable {

		public var title: String?
		public var description: String?

		public init(title: String? = nil, description: String? = nil) {
			self.title = title
			self.description = description
		}
	}
}

extension YTO.Localization: Mockable {
	public static let mock = YTO.Localization(
		title: "Mock Localized Title",
		description: "Mock localized description content"
	)
}
