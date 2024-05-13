import Foundation
import SwiftAPIClient

extension Amazon {
    
    public struct Auth {

        public static let baseURL = URL(string: "https://api.amazon.com/auth/o2")!
        public let client: APIClient
        
        public init(
            client: APIClient = APIClient()
        ) {
            self.client = client.url(Self.baseURL)
        }
        
        public func codepair(
            responseType: Amazon.Objects.ResponseType = .deviceCode,
            clientID: String,
            scope: [Amazon.Objects.Scope]
        ) async throws {
            try await client("create", "codepair")
                .bodyEncoder(
                    .formURL(
                        keyEncodingStrategy: .convertToSnakeCase,
                        arrayEncodingStrategy: .separator(" ")
                    )
                )
                .body(Amazon.Objects.PostCodePair(response_type: responseType, client_id: clientID, scope: scope))
                .post()
        }
    }
}

extension Amazon.Objects {
    
    public struct PostCodePair: Codable {
        public var response_type: Amazon.Objects.ResponseType
        public var client_id: String
        public var scope: [Amazon.Objects.Scope]
        public init(response_type: Amazon.Objects.ResponseType, client_id: String, scope: [Amazon.Objects.Scope]) {
            self.response_type = response_type
            self.client_id = client_id
            self.scope = scope
        }
    }
    
    public struct Scope: Hashable, ExpressibleByStringLiteral, LosslessStringConvertible, Codable {

        public static let profile = Self("profile")
        public static let postalCode = Self("postal_code")

        public var value: String
        public var description: String { value }
        public init(_ value: String) { self.value = value }
        public init(from decoder: any Decoder) throws { try self.init(String(from: decoder)) }
        public init(stringLiteral value: String) { self.init(value) }
        public func encode(to encoder: any Encoder) throws { try value.encode(to: encoder) }
    }
    
    public struct ResponseType: Hashable, ExpressibleByStringLiteral, LosslessStringConvertible, Codable {
        
        public static let deviceCode = Self("device_code")

        public var value: String
        public var description: String { value }
        public init(_ value: String) { self.value = value }
        public init(from decoder: any Decoder) throws { try self.init(String(from: decoder)) }
        public init(stringLiteral value: String) { self.init(value) }
        public func encode(to encoder: any Encoder) throws { try value.encode(to: encoder) }
    }
}
