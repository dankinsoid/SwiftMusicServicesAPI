//
//  SpotifyRequest.swift
//  MusicImport
//
//  Created by Daniil on 20.07.2020.
//  Copyright © 2020 Данил Войдилов. All rights reserved.
//

import Foundation
import SwiftHttp
import AsyncAlgorithms

public protocol SpotifyPaging {
    associatedtype NextParameter
    associatedtype Item
    var items: [Item] { get }
    func nextURL(parameters: NextParameter) -> HttpUrl?
}

extension SPPaging: SpotifyPaging {

    public func nextURL(parameters: Void) -> HttpUrl? {
        next.flatMap { HttpUrl(string: $0) }
    }

    public func nextURL() -> HttpUrl? {
        nextURL(parameters: ())
    }
}

extension Spotify.API {

    public func pagingRequest<Output: SpotifyPaging & Decodable>(
        output: Output.Type,
        executor: @escaping (HttpRequest) async throws -> HttpResponse,
        url: HttpUrl,
        method: HttpMethod,
        body: Data? = nil,
        parameters: Output.NextParameter,
        headers: [HttpHeaderKey: String],
        validators: [HttpResponseValidator] = [HttpStatusCodeValidator()]
    ) -> AsyncThrowingStream<[Output.Item], Error> {
        AsyncThrowingStream { cont in
            self.executeNext(
                output: output,
                request: {
                    try await self.decodableRequest(
                        executor: executor,
                        url: url,
                        method: method,
                        body: body,
                        headers: headers,
                        validators: validators
                    )
                },
                observer: cont,
                parameters: parameters
            )
        }
    }

    private func executeNext<Output: SpotifyPaging & Decodable>(output: Output.Type, request: @escaping () async throws -> Output, observer: AsyncThrowingStream<[Output.Item], Error>.Continuation, parameters: Output.NextParameter) {
        Task {
            do {
                let result = try await request()
                observer.yield(result.items)
                if let url = result.nextURL(parameters: parameters) {
                    self.executeNext(
                        output: output,
                        request: { try await self.next(url: url) },
                        observer: observer,
                        parameters: parameters
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