import Foundation
import SwiftAPIClient

public extension TDO {

	/** object containing references to the primary source of the error */
	struct ErrorObjectSource: Codable, Equatable, Sendable, CustomStringConvertible {

		/** string indicating the name of a single request header which caused the error */
		public var header: String?
		/** string indicating which URI query parameter caused the error. */
		public var parameter: String?
		/** a JSON Pointer [RFC6901] to the value in the request document that caused the error */
		public var pointer: String?

		public var description: String {
			var result = ""
			if let header {
				result += "Header: \(header)\n"
			}
			if let parameter {
				result += "Parameter: \(parameter)\n"
			}
			if let pointer {
				result += "JSON Pointer: \(pointer)\n"
			}
			return result.isEmpty ? "No error source information" : result
		}

		public enum CodingKeys: String, CodingKey {

			case header
			case parameter
			case pointer
		}

		public init(
			header: String? = nil,
			parameter: String? = nil,
			pointer: String? = nil
		) {
			self.header = header
			self.parameter = parameter
			self.pointer = pointer
		}
	}
}
