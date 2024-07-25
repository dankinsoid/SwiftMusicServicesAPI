import Foundation

extension SoundCloud.Objects {
    
    public struct Error: LocalizedError, Codable, Equatable, CustomStringConvertible {

        public var errors: [String]
        public var description: String { errors.joined(separator: ", ") }
        public var errorDescription: String? { errors.first }

        public init(errors: [String]) {
            self.errors = errors
        }
    }
}
