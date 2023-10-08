import Foundation
import SwiftHttp
import SwiftMusicServicesApi

public extension AppleMusic.API {
	func dataRequest<T: Decodable>(
		url: HttpUrl,
		method: HttpMethod = .get,
		body: some Encodable,
		headers: [HttpHeaderKey: String] = [:],
		limit: Int? = nil,
		auth: Bool = true,
		validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]
	) -> AsyncThrowingStream<[T], Error> {
		AsyncThrowingStream { cont in
			self.executeNext(
				output: T.self,
				url: url,
				limit: limit,
				request: {
					try await self.codableRequest(
						url: url,
						method: method,
						headers: self.headers(with: headers, auth: auth),
						body: body,
						validators: validators
					)
				},
				observer: cont,
				auth: auth,
				validators: validators
			)
		}
	}

	func dataRequest<T: Decodable>(
		url: HttpUrl,
		method: HttpMethod = .get,
		body: Data? = nil,
		headers: [HttpHeaderKey: String] = [:],
		auth: Bool = true,
		limit: Int? = nil,
		validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]
	) -> AsyncThrowingStream<[T], Error> {
		AsyncThrowingStream { cont in
			self.executeNext(
				output: T.self,
				url: url,
				limit: limit,
				request: {
					try await self.decodableRequest(
						url: url,
						method: method,
						body: body,
						headers: self.headers(with: headers, auth: auth),
						validators: validators
					)
				},
				observer: cont,
				auth: auth,
				validators: validators
			)
		}
	}

	private func executeNext<Output: Decodable>(
		output: Output.Type,
		url: HttpUrl,
		limit: Int? = nil,
		request: @escaping () async throws -> AppleMusic.Objects.Response<Output>,
		observer: AsyncThrowingStream<[Output], Error>.Continuation,
		auth: Bool,
		validators: [HttpResponseValidator]
	) {
		Task {
			do {
				let result = try await request()
				observer.yield(result.data)
				let newLimit = limit.map { $0 - result.data.count }

				if let next = result.next, (newLimit ?? .max) > 0 {
					var newUrl = HttpUrl(string: [baseURL.url.absoluteString, next].map { $0.trimmingCharacters(in: ["/"]) }.joined(separator: "/")) ?? url
					newUrl.query.merge(url.query) { new, _ in new }

					self.executeNext(
						output: output,
						url: newUrl,
						limit: newLimit,
						request: {
							try await self.decodableRequest(
								url: url,
								method: .get,
								headers: self.headers(auth: auth),
								validators: validators
							)
						},
						observer: observer,
						auth: auth,
						validators: validators
					)
				} else {
					observer.finish()
				}
			} catch {
				observer.finish(throwing: error)
			}
		}
	}
}
