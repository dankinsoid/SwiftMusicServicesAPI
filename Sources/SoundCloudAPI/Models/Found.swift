import Foundation
import SwiftAPIClient

public struct Found: Codable, Equatable {

	/** Location URL of the resource. */
	public var location: String?
	/** Status code. */
	public var status: String?

	public enum CodingKeys: String, CodingKey {

		case location
		case status
	}

	public init(
		location: String? = nil,
		status: String? = nil
	) {
		self.location = location
		self.status = status
	}
}
