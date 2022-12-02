import Foundation
import SwiftHttp
import VDCodable

public extension HttpUrl {
	func query(
		from query: some Encodable,
		encoder: URLQueryEncoder = URLQueryEncoder()
	) throws -> HttpUrl {
		try self.query(encoder.encodeParameters(query))
	}
}

public extension HttpRequest {
	/// Set header field for the request
	func header(_ key: HttpHeaderKey, _ value: String) -> HttpRequest {
		var headers = headers
		headers[key] = value
		return HttpRawRequest(url: url, method: method, headers: headers, body: body)
	}
}
