import Foundation

extension YTO {

    public struct Localization: Codable, Equatable {
        
        public var title: String?
        public var description: String?
        
        public init(title: String? = nil, description: String? = nil) {
            self.title = title
            self.description = description
        }
    }
}
