import Foundation
import SwiftAPIClient

public extension TDO {

	/** JSON:API error object */
	struct ErrorObject: Codable, Equatable, Sendable, CustomStringConvertible {

		/** application-specific error code */
		public var code: String?
		/** human-readable explanation specific to this occurrence of the problem */
		public var detail: String?
		/** unique identifier for this particular occurrence of the problem */
		public var id: String?
		public var source: ErrorObjectSource?
		/** HTTP status code applicable to this problem */
		public var status: String?
		
		// A human-readable description of the error object.
		public var description: String {
			var result = ""
			if let code {
				result += "Code: \(code)\n"
			}
			if let detail {
				result += "Detail: \(detail)\n"
			}
			if let id {
				result += "ID: \(id)\n"
			}
			if let source {
				result += "Source: \(source)\n"
			}
			if let status {
				result += "Status: \(status)\n"
			}
			return result.isEmpty ? "No error details available." : result.trimmingCharacters(in: .whitespacesAndNewlines)
		}

		public enum CodingKeys: String, CodingKey {

			case code
			case detail
			case id
			case source
			case status
		}

		public init(
			code: String? = nil,
			detail: String? = nil,
			id: String? = nil,
			source: ErrorObjectSource? = nil,
			status: String? = nil
		) {
			self.code = code
			self.detail = detail
			self.id = id
			self.source = source
			self.status = status
		}
	}
}
