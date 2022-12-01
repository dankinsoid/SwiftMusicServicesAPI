import Foundation
import SwiftHttp
import VDCodable

extension HttpUrl {

	public func query<T: Encodable>(from query: T, encoder: URLQueryEncoder = URLQueryEncoder()) throws -> HttpUrl {
		try self.query(encoder.encodeParameters(query))
	}
}

public extension HttpRequest {
    
    /// Set header field for the request
    func header(_ key: HttpHeaderKey, _ value: String) -> HttpRequest {
        var headers = self.headers
        headers[key] = value
        return HttpRawRequest(url: url, method: method, headers: headers, body: body)
    }
}

public extension HttpClient {
    
    /// Set header field for all requests
    func header(_ key: HttpHeaderKey, _ value: String) -> HttpClient {
        intercept { req, executor in
            try await executor(req.header(key, value))
        }
    }
    
    /// Validates a HttpResponse using an array of validators
    func validate(_ validators: [HttpResponseValidator]) -> HttpClient {
        intercept { req, executor in
            let response = try await executor(req)
            try HttpResponseValidation(validators).validate(response)
            return response
        }
    }
    
    /// Validates a HttpResponse using an array of validators
    func validate(_ validators: HttpResponseValidator...) -> HttpClient {
        validate(validators)
    }
    
    /// Validates a HttpResponse using an array of validators
    func validateStatusCode(successCode: HttpStatusCode? = nil) -> HttpClient {
        validate(HttpStatusCodeValidator(successCode))
    }
}
