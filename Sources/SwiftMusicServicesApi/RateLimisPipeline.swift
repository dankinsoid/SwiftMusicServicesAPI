import Foundation
import SwiftHttp

private final actor RateRequestHttpClient: HttpClient {

	let client: HttpClient
	let errorCode: HttpStatusCode
	let timeout: Double
	let maxCount: UInt
	private var waitTask: Task<Void, Error>?
	private let barrier = Barrier()

	init(
		client: HttpClient,
		errorCode: HttpStatusCode = .tooManyRequests,
		timeout: Double,
		maxCount: UInt
	) {
		self.client = client
		self.errorCode = errorCode
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
			res.statusCode == errorCode,
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
		errorCode: HttpStatusCode = .tooManyRequests,
		timeout: Double = 30,
		maxCount: UInt = 10
	) -> HttpClient {
		RateRequestHttpClient(
			client: self,
			errorCode: errorCode,
			timeout: timeout,
			maxCount: maxCount
		)
	}
}
