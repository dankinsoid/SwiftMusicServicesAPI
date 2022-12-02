import Foundation
import SwiftHttp

private final actor RateRequestHttpClient: HttpClient {

	let client: HttpClient
	let errorCodes: Set<HttpStatusCode>
	let timeout: Double
	let maxCount: UInt
	private var waitTask: Task<Void, Error>?
	private let barrier = Barrier()

	init(
		client: HttpClient,
		errorCodes: Set<HttpStatusCode>,
		timeout: Double,
		maxCount: UInt
	) {
		self.client = client
		self.errorCodes = errorCodes
		self.timeout = timeout
		self.maxCount = maxCount
	}

	func dataTask(_ req: HttpRequest) async throws -> HttpResponse {
		try await client.dataTask(req)
	}

	func downloadTask(_ req: HttpRequest) async throws -> HttpResponse {
		try await client.downloadTask(req)
	}

	func uploadTask(_ req: HttpRequest) async throws -> HttpResponse {
		try await client.uploadTask(req)
	}

	private func execute(
		_ req: HttpRequest,
		_ task: (HttpRequest) async throws -> HttpResponse
	) async throws -> HttpResponse {
		try await barrier.wait()
		var res = try await task(req)
		var count: UInt = 0
		while
			errorCodes.contains(res.statusCode),
			count < maxCount
		{
			count += 1
			try await barrier.sleep(seconds: timeout)
			res = try await task(req)
		}
		return res
	}
}

public extension HttpClient {

	func rateLimit(
		errorCodes: Set<HttpStatusCode> = [.tooManyRequests],
		timeout: Double = 30,
		maxCount: UInt = 10
	) -> HttpClient {
		RateRequestHttpClient(
			client: self,
			errorCodes: errorCodes,
			timeout: timeout,
			maxCount: maxCount
		)
	}
}
