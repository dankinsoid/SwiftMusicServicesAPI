import Foundation
import SwiftHttp
import VDCodable

extension HttpUrl {

	public func query<T: Encodable>(from query: T, encoder: URLQueryEncoder = URLQueryEncoder()) throws -> HttpUrl {
		try self.query(encoder.encodeParameters(query))
	}
}
