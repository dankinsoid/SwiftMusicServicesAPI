import Foundation

public extension Tidal.Objects {

    struct Error: Codable, LocalizedError, CustomStringConvertible, Equatable, Sendable {

        public var status: Int
        public var subStatus: Int?
        public var error: String
        public var userMessage: String?

        public var description: String {
            "\(status) - \(subStatus ?? 0): \(error) - \(userMessage ?? "")"
        }

        public var errorDescription: String? {
            userMessage
        }

        public init(status: Int = 400, subStatus: Int? = nil, error: String, userMessage: String? = nil) {
            self.status = status
            self.subStatus = subStatus
            self.error = error
            self.userMessage = userMessage
        }

        public static func == (lhs: Tidal.Objects.Error, rhs: Tidal.Objects.Error) -> Bool {
            lhs.error == rhs.error
        }
    }
}
