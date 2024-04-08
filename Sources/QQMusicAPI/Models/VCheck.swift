import Foundation

public enum VCheck: Int, Codable {

    case notTransmitted = 0
    case verificationFailed = 1
    case unknown = 999

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let value = try container.decode(Int.self)
        self = VCheck(rawValue: value) ?? .unknown
    }
}
