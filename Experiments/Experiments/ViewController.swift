import UIKit
import WebKit
import TidalAPI
import SwiftAPIClient

final class ViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    var webView: WKWebView?
    let api = Tidal.Auth(
        client: APIClient().logger(.none),
        clientID: Tidal.API.desktopClientID,
        clientSecret: "",
        redirectURI: Tidal.Auth.redirectURIDesktop
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        let contentController = WKUserContentController()
//        contentController.add(ScriptHandler(controller: self), name: "documentLoaded")

        let configuration = WKWebViewConfiguration()
        configuration.preferences = WKPreferences()
        configuration.websiteDataStore = .nonPersistent()
        configuration.userContentController = contentController
        configuration.applicationNameForUserAgent = "Version/17.4.1 Safari/605.1.15"
        
        webView = createWebView(configuration: configuration)

        var request = URLRequest(url: api.authURL()!)
        request.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData

        let script = """
        document.addEventListener("DOMContentLoaded", function(event) {
            webkit.messageHandlers.documentLoaded.postMessage(null);
        });
        """
        contentController.addUserScript(WKUserScript(source: script, injectionTime: .atDocumentEnd, forMainFrameOnly: true))

        webView?.load(request)
    }

    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction) async -> WKNavigationActionPolicy {
        if let url = navigationAction.request.url, url.absoluteString.hasPrefix("tidal") {
            if let code = try? api.codeFrom(redirected: url.absoluteString) {
                let token = try? await api.token(code: code, cache: .keychain)
                dump(token)
            }
            return .cancel
        }
        return .allow
    }

    @discardableResult
    private func createWebView(configuration: WKWebViewConfiguration) -> WKWebView {
        configuration.defaultWebpagePreferences.allowsContentJavaScript = true
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let webView = WKWebView(frame: view.bounds, configuration: configuration)
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
//        let observer = CookieStoreObserver(controller: self)
//        webView.configuration.websiteDataStore.httpCookieStore.add(observer)
//        cookiesObservers.append((webView, observer))
        return webView
    }
}
