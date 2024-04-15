import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

extension Amazon.Music {
    
    public struct DeviceAPI {
        
        public static let baseURL = URL(string: "https://music-api.amazon.com/")!
        
        public let client: APIClient
        
        public init(
            client: APIClient = APIClient()
        ) {
            self.client = client
                .url(Self.baseURL)
                .auth(enabled: true)
        }
    }
}
