import Foundation
import SwiftHttp
import SwiftAPIClient

public extension APIClient {
    
    func rateLimit(
        errorCodes: Set<HTTPResponse.Status> = [.tooManyRequests],
        timeout: Double = 30,
        maxCount: UInt = 10
    ) -> APIClient {
        httpClientMiddleware(
            RateRequestHttpClient(
                errorCodes: errorCodes,
                timeout: timeout,
                maxCount: maxCount
            )
        )
    }
}

private struct RateRequestHttpClient: HTTPClientMiddleware {

    private static let barrier = Barrier()

	let errorCodes: Set<HTTPResponse.Status>
	let timeout: Double
	let maxCount: UInt

	init(
        errorCodes: Set<HTTPResponse.Status>,
		timeout: Double,
		maxCount: UInt
	) {
		self.errorCodes = errorCodes
		self.timeout = timeout
		self.maxCount = maxCount
	}

    func execute<T>(
        request: HTTPRequestComponents,
        configs: APIClient.Configs,
        next: @escaping @Sendable (HTTPRequestComponents, APIClient.Configs) async throws -> (T, HTTPResponse)
    ) async throws -> (T, HTTPResponse) {
        try await Self.barrier.wait()
        var res = try await next(request, configs)
        var count: UInt = 0
        while
            errorCodes.contains(res.1.status),
            count < maxCount
        {
            count += 1
            try await Self.barrier.sleep(seconds: timeout)
            res = try await next(request, configs)
        }
        return res
    }
}
