import Foundation

extension Amazon.Objects {
    
    public struct Error: LocalizedError, Codable, CustomStringConvertible, Equatable {
        
        public var error: String
        public var description: String { error }
        public var errorDescription: String? { error }
        
        public init(error: String) {
            self.error = error
        }
    }
}
