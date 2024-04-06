import Foundation
import SwiftAPIClient

public struct ErrorType: Codable, Equatable, Error, CustomStringConvertible {

	public var code: Int?
	public var link: String?
	public var message: String?
    
    public var errorDescription: String? {
        message
    }
    
    public var description: String {
        message ?? "No message"
    }

	public enum CodingKeys: String, CodingKey {

		case code
		case link
		case message
	}

	public init(
		code: Int? = nil,
		link: String? = nil,
		message: String? = nil
	) {
		self.code = code
		self.link = link
		self.message = message
	}
}
