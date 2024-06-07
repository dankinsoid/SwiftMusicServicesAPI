import Foundation

extension YouTube.Objects {
    
    public struct Player: Codable, Hashable {
        public var embedHtml: String
        
        public init(embedHtml: String) {
            self.embedHtml = embedHtml
        }
    }
}
