import Foundation
import CryptoSwift

package func generateCodeChallenge(
    verifier: String? = nil,
    method: CodeChallengeMethod
) -> (codeVerifier: String, codeChallenge: String)? {
    let codeVerifier = verifier ?? generateCodeVerifier()
    switch method {
    case .S256:
        guard let data = codeVerifier.data(using: .ascii) else {
            return nil
        }
        
        let hash = data.sha256()
        let hashData = Data(hash)
        return (codeVerifier, hashData.base64URLEncodedString())
    case .plain:
        return (codeVerifier, codeVerifier)
    }
}

public enum CodeChallengeMethod: String, Hashable, Codable, CaseIterable {
    case S256, plain
}

private func generateCodeVerifier() -> String {
    let characters = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~"
    let length = Int.random(in: 43..<129) // Ensure length is between 43 and 128
    var codeVerifier = ""
    
    for _ in 0..<length {
        if let randomCharacter = characters.randomElement() {
            codeVerifier.append(randomCharacter)
        }
    }
    
    return codeVerifier
}

// Extension to encode data to Base64 URL encoded string
package extension Data {
    
    func base64URLEncodedString() -> String {
        self.base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
