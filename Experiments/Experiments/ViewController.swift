import UIKit
import WebKit
import SoundCloudAPI
import SwiftAPIClient

final class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    var webView: WKWebView?

    override func viewDidLoad() {
        super.viewDidLoad()

        let contentController = WKUserContentController()
//        contentController.add(ScriptHandler(controller: self), name: "documentLoaded")

        let configuration = WKWebViewConfiguration()
        configuration.preferences = WKPreferences()
        configuration.websiteDataStore = .nonPersistent()
        configuration.userContentController = contentController
        configuration.applicationNameForUserAgent = "Version/18.4 Mobile/15E148 Safari/604.1"
        
        webView = createWebView(configuration: configuration)

        var request = URLRequest(url: URL(string: "https://www.deezer.com")!)
//        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData

        let script = """
        document.addEventListener("DOMContentLoaded", function(event) {
            webkit.messageHandlers.documentLoaded.postMessage(null);
        });
        """
        contentController.addUserScript(WKUserScript(source: script, injectionTime: .atDocumentEnd, forMainFrameOnly: true))

        webView?.load(request)
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        if let url = navigationAction.request.url {
            print(url)
            return .allow
        }
        return .allow
    }
    
    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        createWebView(configuration: configuration)
    }

    @discardableResult
    private func createWebView(configuration: WKWebViewConfiguration) -> WKWebView {
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let webView = WKWebView(frame: view.bounds, configuration: configuration)
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        webView.navigationDelegate = self
        
        let pagePreferences = WKWebpagePreferences()
        pagePreferences.allowsContentJavaScript = true
        webView.configuration.defaultWebpagePreferences = pagePreferences
        
        webView.allowsBackForwardNavigationGestures = true
        webView.backgroundColor = .clear
        webView.isOpaque = false
        webView.scrollView.backgroundColor = .clear
        webView.scrollView.contentInsetAdjustmentBehavior = .never
        webView.uiDelegate = self
        let observer = CookieStoreObserver(controller: self)
        webView.configuration.websiteDataStore.httpCookieStore.add(observer)
        cookiesObservers.append((webView, observer))
        return webView
    }
    
    private var cookiesObservers: [(WKWebView, CookieStoreObserver)] = []
    
    private final class CookieStoreObserver: NSObject, WKHTTPCookieStoreObserver {
        
        private weak var controller: ViewController?
        
        init(controller: ViewController) {
            self.controller = controller
        }
        
        func cookiesDidChange(in cookieStore: WKHTTPCookieStore) {
            cookieStore.getAllCookies { cookies in
                print(cookies)
            }
        }
    }
}

public enum Dezeer {
    
    public struct API {

        public var client: APIClient

        public init(
            client: APIClient,
            cache: SecureCacheService,
            clientID: String,
            redirectURI: String
        ) {
            self.client = client.url("https://api.deezer.com")
//                .tokenRefresher(cacheService: cache, expiredStatusCodes: [.unauthorized, .forbidden]) { refreshToken, _, _ in
//                    let result = try await SoundCloud.OAuth2(
//                        client: client,
//                        clientID: clientID,
//                        redirectURI: redirectURI
//                    )
//                        .refreshToken(cache: cache)
//                    return (result.accessToken, refreshToken, result.expiresIn.map { Date(timeIntervalSinceNow: $0) })
//                } auth: { token in
//                        .bearer(token: token)
//                }
                .bodyEncoder(.json(dateEncodingStrategy: .iso8601))
                .bodyDecoder(.json(dateDecodingStrategy: .deezer))
                .queryEncoder(.urlQuery(arrayEncodingStrategy: .commaSeparator))
                .auth(enabled: true)
                .errorDecoder(.decodable(SCO.Error.self))
                .httpResponseValidator(.statusCode)
        }
    }
    
    public struct OAuth {
        
        public var client: APIClient
        
        public init(
            client: APIClient,
            cache: SecureCacheService,
            clientID: String,
            redirectURI: String
        ) {
            self.client = client.url("https://api.deezer.com")
            //                .tokenRefresher(cacheService: cache, expiredStatusCodes: [.unauthorized, .forbidden]) { refreshToken, _, _ in
            //                    let result = try await SoundCloud.OAuth2(
            //                        client: client,
            //                        clientID: clientID,
            //                        redirectURI: redirectURI
            //                    )
            //                        .refreshToken(cache: cache)
            //                    return (result.accessToken, refreshToken, result.expiresIn.map { Date(timeIntervalSinceNow: $0) })
            //                } auth: { token in
            //                        .bearer(token: token)
            //                }
                .bodyEncoder(.json(dateEncodingStrategy: .iso8601))
                .bodyDecoder(.json(dateDecodingStrategy: .deezer))
                .queryEncoder(.urlQuery(arrayEncodingStrategy: .commaSeparator))
                .auth(enabled: true)
                .errorDecoder(.decodable(SCO.Error.self))
                .httpResponseValidator(.statusCode)
        }
    }
}

extension JSONDecoder.DateDecodingStrategy {
    
    public static let deezer: JSONDecoder.DateDecodingStrategy = .custom { decoder in
        let container = try decoder.singleValueContainer()
        let dateString: String
        do {
            dateString = try container.decode(String.self)
        } catch {
            let time = try container.decode(Double.self)
            return Date(timeIntervalSince1970: time)
        }
        if let date = isoDateFormatter.date(from: dateString) ?? dateFormatter.date(from: dateString) {
            return date
        }
        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format: \(dateString)")
        
    }
}

private let isoDateFormatter: ISO8601DateFormatter = {
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    return dateFormatter
}()

private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    return dateFormatter
}()
