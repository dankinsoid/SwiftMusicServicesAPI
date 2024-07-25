import Foundation

extension SoundCloud.Objects {
    
    public struct Recommendation: Equatable, Codable {

        public var user: User
        
        public init(user: User) {
            self.user = user
        }
    }
}
