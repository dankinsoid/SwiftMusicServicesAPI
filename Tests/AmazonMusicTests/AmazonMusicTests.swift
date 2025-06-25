@testable import AmazonMusicAPI
import XCTest
import SwiftAPIClient

final class AmazonMusicTests: XCTestCase {
	
	let api = Amazon.Music.BrowserAPI(
		client: APIClient().loggingComponents([.full]),
		cache: MockSecureCacheService(),
		webCookies: [:]
	)
	
	func testHome() async throws {
		api.userAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/137.0.0.0 Safari/537.36"
		try await print(api.showHome())
	}
}
