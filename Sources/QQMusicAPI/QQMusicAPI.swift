import Foundation
import SwiftMusicServicesApi
import SwiftAPIClient

public enum QQMusic {}

extension QQMusic {
    
    public struct API {
        
        public enum BaseURL: String {
            
            /// Official primary domain name
            case baseURL = "https://qplaycloud.y.qq.com"
            
            /// Test domain name
            case testBaseURL = "https://test.y.qq.com/opentest"
            
            /// Official Shenzhen center domain name
            case shenzhenBaseURL = "https://opensz.music.qq.com"
            
            /// Official Shanghai Center domain name
            case shanghaiBaseURL = "https://opensh.music.qq.com"
            
            public var url: URL {
                URL(string: rawValue)!
            }
        }

        public let appID: String
        public let appKey: String
        public let appPrivateKey: String?
        public let client: APIClient
        
        public init(
            baseURL: BaseURL,
            appID: String,
            appKey: String,
            appPrivateKey: String?
        ) {
            self.client = APIClient(baseURL: baseURL.url)
            self.appID = appID
            self.appKey = appKey
            self.appPrivateKey = appPrivateKey
        }
    }
}
