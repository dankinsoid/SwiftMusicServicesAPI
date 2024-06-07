import Foundation

extension YouTube.Objects {
    
    public struct Player: Codable, Hashable {
        public var embedHtml: String
        public var embedHeight: Int?
        public var embedWidth: Int?
        
        public init(embedHtml: String) {
            self.embedHtml = embedHtml
        }
    }
}
