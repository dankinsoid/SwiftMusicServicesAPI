import Foundation

extension YouTube.Music.Objects {
    
    public struct Thumbnails: Codable, Hashable {
        
        public var `default`: Thumbnail?
        public var medium: Thumbnail?
        public var high: Thumbnail?
        public var standard: Thumbnail?
        public var maxres: Thumbnail?
    
        public init(medium: Thumbnail? = nil, high: Thumbnail? = nil, standard: Thumbnail? = nil, maxres: Thumbnail? = nil) {
            self.medium = medium
            self.high = high
            self.standard = standard
            self.maxres = maxres
        }

        public struct Thumbnail: Codable, Hashable {

            public var url: String
            public var width: Int?
            public var height: Int?
            
            public init(url: String, width: Int? = nil, height: Int? = nil) {
                self.url = url
                self.width = width
                self.height = height
            }
        }
    }
}
