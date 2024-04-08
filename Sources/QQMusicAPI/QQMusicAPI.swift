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
                .bodyDecoder(.json(dateDecodingStrategy: .qq))
                .errorDecoder(.decodable(QQResponseCommon.self))
                .path("rpc_proxy", "fcgi-bin", "music_open_api.fcg")
                .httpResponseValidator(.qq)
            
            self.appID = appID
            self.appKey = appKey
            self.appPrivateKey = appPrivateKey
        }
        
        public func client(for cmd: String) -> APIClient {
            client.query("opi_cmd", cmd)
        }
    }
}

private extension JSONDecoder.DateDecodingStrategy {

    static var qq: Self {
        .custom { decoder in
            do {
                let double = try Double(from: decoder)
                return Date(timeIntervalSince1970: double)
            } catch {
                let string = try String(from: decoder)
                guard let date = qqDateFormatter.date(from: string) else {
                    throw DecodingError.dataCorrupted(
                        DecodingError.Context(
                            codingPath: decoder.codingPath,
                            debugDescription: "Expected date string to be in yyyy-MM-dd format, but it was \(string)"
                        )
                    )
                }
                return date
            }
        }
    }
}

private let qqDateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd"
    return formatter
}()
