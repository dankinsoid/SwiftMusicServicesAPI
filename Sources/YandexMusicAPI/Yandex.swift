import Foundation
import SwiftAPIClient
@_exported import SwiftMusicServicesApi

public typealias YM = Yandex.Music
public typealias YMO = Yandex.Music.Objects

public enum Yandex {
    public enum Music {}
}

public extension Yandex.Music {
    enum Objects {}
    
    final class API {
        public static let clientID = "23cabbbdc6cd418abb4b39c32c41195d"
        public static let clientSecret = "53bc75238f0c4d08a118e51fe9203300"
        
        public static let baseURL = URL(string: "https://api.music.yandex.net")!
        public static let authURL = URL(string: "https://oauth.yandex.ru")!
        public static let passportURL = URL(string: "https://passport.yandex.com")!
        public static let mobileproxyPassportURL = URL(string: "https://mobileproxy.passport.yandex.net")!
        
        public static var uuid = UUID().uuidString.lowercased().replacingOccurrences(of: "-", with: "")
        public static var ifv = UUID()
        
        public var client: APIClient
        public var token: String? {
            get { lock.withReaderLock{ _token } }
            set { lock.withWriterLockVoid { _token = newValue } }
        }
        private var _token: String?
        private let lock = ReadWriteLock()
        
        public init(
            client: APIClient = APIClient(),
            token: String? = nil
        ) {
            _token = token
            self.client = client
                .url(API.baseURL)
                .bodyDecoder(YandexDecoder())
                .errorDecoder(.yandexMusic)
                .queryEncoder(.urlQuery(arrayEncodingStrategy: .commaSeparator, nestedEncodingStrategy: .json))
                .header(.userAgent, "Maple/667 (iPhone; 17.\(Int.random(in: 1...4)).1; Scale/3.0)")
                .header("X-Yandex-Music-Client", "Yandex.Music/672.155743")
                .httpResponseValidator(.statusCode)
                .auth(enabled: true)

            self.client = self.client.auth(AuthModifier { [weak self] request, _ in
                if let token = self?.token {
                    request.headers[.authorization] = "OAuth \(token)"
                }
            })
        }

        public static func url(coverUri: String?) -> URL? {
            guard let uri = coverUri else {
                return nil
            }
            return URL(string: "https://" + uri.replacingOccurrences(of: "%%", with: "200x200"))
        }
    }
}
