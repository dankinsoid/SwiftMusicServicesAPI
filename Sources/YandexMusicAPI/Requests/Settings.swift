import Foundation
import SwiftHttp
import VDCodable

public extension Yandex.Music.API {

    func settings() async throws -> YMO.Settings {
        try await request(
            url: baseURL.path("account", "settings"),
            method: .get
        )
    }
}
