import Foundation

extension YTMO {
    
    public struct PrivacyStatus: LosslessStringConvertible, Codable, Hashable {
        
        public static let `private` = PrivacyStatus("private")
        
        public var value: String
        public var description: String { value }
        
        public init(_ value: String) {
            self.value = value
        }
        
        public init(from decoder: any Decoder) throws {
            try self.init(String(from: decoder))
        }
        
        public func encode(to encoder: any Encoder) throws {
            try value.encode(to: encoder)
        }
    }
}
