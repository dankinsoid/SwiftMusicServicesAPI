import AppleMusicAPI
import Foundation
import JWTKit

public extension AppleMusic.API {
	static func developerToken(keyId: String, teamId: String, key: String) throws -> String {
		let signers = JWTSigners()
		try signers.use(.es256(key: .private(pem: key)))
		return try signers.sign(AppleMusic.Claims(iss: IssuerClaim(value: teamId)), kid: JWKIdentifier(string: keyId))
	}
}

#if canImport(StoreKit)
	import StoreKit

	@available(macOS 11.0, *)
	public extension AppleMusic.API {
		static func userTokens(keyId: String, teamId: String, key: String) async throws -> AppleMusic.Objects.Tokens {
			try await withCheckedThrowingContinuation {
				userTokens(keyId: keyId, teamId: teamId, key: key, completion: $0.resume)
			}
		}

		static func userTokens(keyId: String, teamId: String, key: String, completion: @escaping (Result<AppleMusic.Objects.Tokens, Error>) -> Void) {
			do {
				let developerToken = try developerToken(keyId: keyId, teamId: teamId, key: key)
				userTokens(developerToken: developerToken, completion: completion)
			} catch {
				completion(.failure(error))
			}
		}

		static func userTokens(developerToken token: String) async throws -> AppleMusic.Objects.Tokens {
			try await withCheckedThrowingContinuation {
				userTokens(developerToken: token, completion: $0.resume)
			}
		}

		static func userTokens(developerToken token: String, completion: @escaping (Result<AppleMusic.Objects.Tokens, Error>) -> Void) {
			SKCloudServiceController().requestUserToken(forDeveloperToken: token) { result, error in
				if let string = result {
					completion(.success(AppleMusic.Objects.Tokens(token: token, userToken: string)))
				} else {
					completion(.failure(error ?? Unknown()))
				}
			}
		}
	}

	private struct Unknown: Error {}
#endif

extension AppleMusic {
	struct Claims: JWTPayload {
		var iss: IssuerClaim
		var iat = IssuedAtClaim(value: Date())
		var exp = ExpirationClaim(value: Date(timeIntervalSinceNow: 15_777_000 / 2))

		func verify(using _: JWTSigner) throws {
			try exp.verifyNotExpired()
		}
	}
}
