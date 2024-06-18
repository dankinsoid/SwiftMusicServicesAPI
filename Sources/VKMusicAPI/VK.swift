import Foundation
import SwiftAPIClient
@_exported import SwiftMusicServicesApi
import VDCodable

public struct VK {

	public final class API {
		public static var baseURL = URL(string: "https://m.vk.com")!
        private static let userAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_4 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.4.1 Safari/605.1.15"

		private(set) public var client = APIClient()
        private let lock = ReadWriteLock()
        public var webCookies: [String: String] {
            get {
                lock.withReaderLock { _webCookies }
            }
            set {
                lock.withWriterLockVoid {
                    _webCookies = newValue
                }
                Task {
                    try await cache.save(newValue, for: .cookies)
                }
            }
        }
        public var userAgent: String {
            get {
                lock.withReaderLock { _userAgent }
            }
            set {
                lock.withWriterLockVoid {
                    _userAgent = newValue
                }
                Task {
                    try await cache.save(newValue, for: .userAgent)
                }
            }
        }
        public let multipartEncoder = MultipartFormDataEncoder()
        public let cache: SecureCacheService
        private var _webCookies: [String: String] = [:]
        private var _userAgent = VK.API.userAgent

		public init(
            client: APIClient,
            cache: SecureCacheService,
            webCookies: [String: String] = [:]
        ) {
            _webCookies = webCookies
            self.cache = cache

			self.client = client
                .url(VK.API.baseURL)
                .httpResponseValidator(.statusCode)
                .auth(enabled: true)
                .redirect(behaviour: .doNotFollow)
                .modifyRequest { [weak self] components, configs in
                    guard !configs.minimal else { return }
                    components.headers[.accept] = "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7"
                    components.headers[.origin] = VK.API.baseURL.absoluteString
                    components.headers[.acceptLanguage] = "ru-RU,ru;q=0.9,en-US;q=0.8,en;q=0.7"
                    components.headers[.userAgent] = self?.userAgent ?? VK.API.userAgent
                }
                .auth(
                    AuthModifier { [weak self] components in
                        components.headers[.cookie] = (self?.webCookies ?? webCookies)
                            .map { "\($0.key)=\($0.value)" }
                            .joined(separator: "; ")
                    }
                )
                .httpClientMiddleware(VKRedirectMiddleware(api: self))

            Task { [self] in
                userAgent = (try? await cache.load(for: .userAgent)) ?? VK.API.userAgent
                self.webCookies = ((try? await cache.load(for: .cookies) as [String: String]?) ?? [:]).merging(webCookies) { _, n in n }
            }
		}
	}
}

extension SecureCacheServiceKey {
    public static let userAgent = SecureCacheServiceKey("UserAgent")
    public static let cookies = SecureCacheServiceKey("Cookies")
}

extension APIClient.Configs {

    public var minimal: Bool {
        get { self[\.minimal] ?? false }
        set { self[\.minimal] = newValue }
    }
}

public extension APIClient {

    var xmlHttpRequest: APIClient {
        header(.xRequestedWith, "XMLHttpRequest")
    }
}

public extension Serializer where Response == Data, T: HTMLStringInitable {

    /// Creates a `Serializer` for a specific `HTMLStringInitable` type.
    /// - Returns: A `Serializer` that decodes the response data into the specified `HTMLStringInitable` type.
    static func htmlInitable(_: T.Type) -> Self {
        Self { data, configs in
            let string: String
            do {
                string = try JSONDecoder().decode(VKPage.self, from: data).html
            } catch {
                string = String(data: data, encoding: .utf8) ?? String(data: data, encoding: .windowsCP1251) ?? ""
            }
            return try T(htmlString: string)
        }
    }

    /// A static property to get a `Serializer` for the generic `HTMLStringInitable` type.
    static var htmlInitable: Self {
        .htmlInitable(T.self)
    }
}

public extension VK {
	enum Objects {}
}

private struct VKRedirectMiddleware: HTTPClientMiddleware {

    weak var api: VK.API?
    private var client: APIClient {
        (api?.client ?? APIClient())
            .configs(\.insideRedirect, true)
            .configs(\.ignoreStatusCodeValidator, true)
            .removeHeader(.xRequestedWith)
    }

    func execute<T>(
        request: HTTPRequestComponents,
        configs: APIClient.Configs,
        next: @escaping (HTTPRequestComponents, APIClient.Configs) async throws -> (T, HTTPResponse)
    ) async throws -> (T, HTTPResponse) {
        let (value, resp) = try await next(request, configs)
        guard !configs.insideRedirect else { return (value, resp) }
        
        var newRemixnsid: String?
        var newRemixsid: String?
        var redirectedURLs: Set<URL> = []
        var response = resp
        var request = request

        while let url = redirect(data: value, response: response) {
            if redirectedURLs.contains(url) {
                return try await next(request, configs)
            }
            redirectedURLs.insert(url)
            guard let setCookie = response.headerFields[.setCookie] else {
                response = try await client.url(url).call(.httpResponse).1
                continue
            }
            for string in setCookie.components(separatedBy: ", ").flatMap({ $0.components(separatedBy: "; ") }) {
                let comp = string.components(separatedBy: "=")
                guard comp.count > 1 else { continue }
                newRemixsid = find(cookie: "remixsid", comp: comp, request: &request)
                newRemixnsid = find(cookie: "remixnsid", comp: comp, request: &request)
                find(cookie: "p", comp: comp, request: &request)
                find(cookie: "remixmdevice", comp: comp, request: &request)
            }
            if newRemixsid != nil, newRemixnsid != nil {
                return try await next(request, configs)
            }
            response = try await client.url(url).call(.httpResponse).1
        }
        return (value, resp)
    }
    
    private func redirect<T>(data: T, response: HTTPResponse) -> URL? {
        let result: URL
        if
            response.status.kind == .redirection,
            let location = response.headerFields[.location],
            let url = URL(string: location)
        {
            result = url
        } else if let data = data as? Data, let location = try? JSONDecoder().decode(Location.self, from: data) {
            result = location.location
        } else {
            return nil
        }
        if result.absoluteString.hasPrefix("http") {
            return result
        } else {
            return URL(
                string: [VK.API.baseURL.absoluteString, result.absoluteString]
                    .map { $0.trimmingCharacters(in: ["/"]) }
                    .joined(separator: "/")
            ) ?? VK.API.baseURL
        }
    }

    @discardableResult
    private func find(cookie: String, comp: [String], request: inout HTTPRequestComponents) -> String? {
        if comp[0] == cookie {
            let value = comp.dropFirst().joined(separator: "=")
            api?.webCookies[cookie] = value
            request.headers[values: .cookie].append("\(cookie)=\(value)")
        }
        return nil
    }
    
    private struct RedirectRecursiveCycle: Error {
        
        let url: URL
    }
}

private extension APIClient.Configs {
    
    var insideRedirect: Bool {
        get { self[\.insideRedirect] ?? false }
        set { self[\.insideRedirect] = true }
    }
}

private struct Location: Codable {
    
    var location: URL
}
