import Foundation

extension Tidal.Objects {
    
    public struct Error: Codable, LocalizedError, CustomStringConvertible, Equatable {

        public var status: Int
        public var sub_status: Int?
        public var error: String
        public var error_description: String?
    
        public var description: String {
            "\(status) - \(sub_status ?? 0): \(error) - \(error_description ?? "")"
        }
        
        public var errorDescription: String? {
            error_description
        }
        
        public init(status: Int = 400, sub_status: Int? = nil, error: String, error_description: String? = nil) {
            self.status = status
            self.sub_status = sub_status
            self.error = error
            self.error_description = error_description
        }
        
        public static func == (lhs: Tidal.Objects.Error, rhs: Tidal.Objects.Error) -> Bool {
            lhs.error == rhs.error
        }
    }
}
