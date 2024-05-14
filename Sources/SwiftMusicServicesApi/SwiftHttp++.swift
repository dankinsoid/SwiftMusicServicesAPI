import Foundation
import SwiftHttp
import VDCodable
import SwiftAPIClient

public extension HttpUrl {

    @_disfavoredOverload
	func query(
		from query: some Encodable,
        encoder: VDCodable.URLQueryEncoder = VDCodable.URLQueryEncoder()
	) throws -> HttpUrl {
		try self.query(encoder.encodeParameters(query))
	}

    func query(
        from query: some Encodable,
        encoder: SwiftAPIClient.URLQueryEncoder = SwiftAPIClient.URLQueryEncoder()
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
