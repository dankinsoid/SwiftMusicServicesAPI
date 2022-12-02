import Foundation
import SwiftHttp

extension HttpClient {

	func pipeline(_ pipeline: @escaping (HttpRequest, (HttpRequest) async throws -> HttpResponse) async throws -> HttpResponse) -> HttpClient {
		PipelineHttpClient(client: self, pipeline: pipeline)
	}
}

private struct PipelineHttpClient: HttpClient {

	let client: HttpClient
	let pipeline: (HttpRequest, (HttpRequest) async throws -> HttpResponse) async throws -> HttpResponse

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
		try await pipeline(req, task)
	}
}
