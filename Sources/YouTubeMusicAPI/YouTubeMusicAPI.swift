import Foundation
import SwiftMusicServicesApi
import SwiftAPIClient

public enum YouTubeMusic {}

extension YouTubeMusic {
    
    public struct API {
        
        public enum BaseURL: String {
            
            /// Official primary domain name
            case baseURL = "https://music.youtube.com"
            
            public var url: URL {
                URL(string: rawValue)!
            }
        }

        public let client: APIClient
        
        public init(
            baseURL: BaseURL
        ) {
            self.client = APIClient(baseURL: baseURL.url)
        }
    }
}
