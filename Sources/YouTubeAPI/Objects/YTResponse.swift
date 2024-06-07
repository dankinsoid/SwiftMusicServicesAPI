import Foundation
import SwiftMusicServicesApi

extension YTMO {

    public struct Response<T: Decodable>: Decodable {

        public var kind: String
        public var etag: String
        public var nextPageToken: String?
        public var prevPageToken: String?
        public var pageInfo: PageInfo?
        @SafeDecodeArray public var items: [T]
        
        public init(kind: String, etag: String, nextPageToken: String? = nil, prevPageToken: String? = nil, pageInfo: PageInfo? = nil, items: [T]) {
            self.kind = kind
            self.etag = etag
            self.nextPageToken = nextPageToken
            self.prevPageToken = prevPageToken
            self.pageInfo = pageInfo
            self.items = items
        }
        
        public struct PageInfo: Codable {
            public var totalResults: Int
            public var resultsPerPage: Int
            
            public init(totalResults: Int, resultsPerPage: Int) {
                self.totalResults = totalResults
                self.resultsPerPage = resultsPerPage
            }
        }
    }
}
