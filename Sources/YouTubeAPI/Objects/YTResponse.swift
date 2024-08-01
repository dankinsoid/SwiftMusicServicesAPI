import Foundation
import SwiftMusicServicesApi

extension YTO {

    public struct Response<T: Decodable>: Decodable {

        public var kind: String
        public var etag: String
        public var nextPageToken: String?
        public var prevPageToken: String?
        public var pageInfo: PageInfo?
        public var items: [T]

        public init(kind: String, etag: String, nextPageToken: String? = nil, prevPageToken: String? = nil, pageInfo: PageInfo? = nil, items: [T]) {
            self.kind = kind
            self.etag = etag
            self.nextPageToken = nextPageToken
            self.prevPageToken = prevPageToken
            self.pageInfo = pageInfo
            self.items = items
        }

        public init(from decoder: any Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            self.kind = try container.decode(String.self, forKey: .kind)
            self.etag = try container.decode(String.self, forKey: .etag)
            self.nextPageToken = try container.decodeIfPresent(String.self, forKey: .nextPageToken)
            self.prevPageToken = try container.decodeIfPresent(String.self, forKey: .prevPageToken)
            self.pageInfo = try container.decodeIfPresent(PageInfo.self, forKey: .pageInfo)
            self.items = try container.decodeIfPresent(SafeDecodeArray<T>.self, forKey: .items)?.array ?? []
        }

        public enum CodingKeys: String, CodingKey {
            
            case kind
            case etag
            case nextPageToken
            case prevPageToken
            case pageInfo
            case items
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
