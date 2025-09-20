import Foundation
import SwiftMusicServicesApi
import XCTest

final class YouTubeMusicTests: XCTestCase {

	func testVerifier() {
		let verifier = "2Q8XVW8RznglNnR6YHsjs3lj5XQDWfiT9g..qIzp_Z7eQyxySYwOKQ-XwORSmh0m1tyPTQhwjRg4QDASXG_.ATE5T2nnDzXDGCqEgG7xtDAdJYvSLh"
		let (_, challenge) = generateCodeChallenge(verifier: verifier, method: .S256)!
		XCTAssertEqual(challenge, "Tm_ypMZvY0KayPJyN_GRVNiIjCCxILORYp7vQb7RP0w")
	}
}
