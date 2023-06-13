#if canImport(UIKit)
	import SwiftHttp
	import UIKit
	import VKMusicAPI
	import WebKit
    import Logging

	open class VKLoginController: UIViewController, WKNavigationDelegate {
        open var client: VK.API = .init(client: UrlSessionHttpClient(logLevel: .debug))
		open var hideOnLogin = false
		public private(set) lazy var webView = WKWebView()
		var successLogin: (VKUser, _ webCookies: [String: String]) -> Void = { _, _ in }
		private var wasPreauthorized = false
		private var loadCount = 0

		public init(client: VK.API = VK.API(client: UrlSessionHttpClient(logLevel: .debug)), successLogin: @escaping (VKUser, _ webCookies: [String: String]) -> Void = { _, _ in }) {
			super.init(nibName: nil, bundle: nil)
			self.successLogin = successLogin
			self.client = client
		}

		public required init?(coder aDecoder: NSCoder) {
			super.init(coder: aDecoder)
		}

		override open func viewDidLoad() {
			super.viewDidLoad()
			webView.frame = view.bounds
			view.addSubview(webView)
			webView.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
				webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
				webView.topAnchor.constraint(equalTo: view.topAnchor),
				webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			])
			webView.navigationDelegate = self
			webView.load(URLRequest(url: VK.API.baseURL.url))
			webView.allowsBackForwardNavigationGestures = true
			view.backgroundColor = .clear
		}

		override open func viewWillAppear(_ animated: Bool) {
			super.viewWillAppear(animated)
			navigationController?.setNavigationBarHidden(true, animated: true)
		}

		@objc private func reload() {
			webView.reload()
		}

		@objc private func close() {
			dismiss(animated: true, completion: nil)
		}

		private func closeIfNeeded() {
			guard hideOnLogin else { return }
			dismiss(animated: true, completion: nil)
		}

		open func webView(_: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
			if navigationAction.request.url?.absoluteString.hasSuffix("feed") == true, loadCount > 0 {
				UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
					self.navigationController?.isToolbarHidden = true
					self.webView.alpha = 0
				})
			}
			decisionHandler(.allow)
		}

		open func webView(_ webView: WKWebView, didFinish _: WKNavigation!) {
			webView.evaluateJavaScript("document.documentElement.outerHTML.toString()", completionHandler: { [weak self] (html: Any?, _: Error?) in
				guard let self, let html = html as? String else { return }

				let cookies = self.getCookies()
				self.client.webCookies = cookies
				let state = VKAuthorizationState(html)

				switch state {
				case let .authorized(user):
					if self.wasPreauthorized == true {
						self.successLogin(user, cookies)
						self.closeIfNeeded()
					} else {
						self.webView.alpha = 1
						self.useThisAccountSheet {
							self.client.webCookies = cookies
							self.successLogin(user, cookies)
							self.closeIfNeeded()
						}
					}
					self.loadCount += 1
				case .preAuthorized:
					self.wasPreauthorized = true
				default:
					break
				}
			})
		}

		open func useThisAccountSheet(onAgree: @escaping () -> Void) {
			actionSheet(title: nil, message: nil)
				.addButton("Продолжить через этот аккаунт", action: onAgree)
				.addButton("Отмена", action: nil)
				.present()
		}

		private func getCookies() -> [String: String] {
			let cookies = URLSession.shared.configuration.httpCookieStorage?.cookies?.filter { $0.domain.contains("vk.com") } ?? []
			return Dictionary(cookies.map { ($0.name, $0.value) }) { _, s in s }
		}
	}

	extension UIViewController {
		func actionSheet(title: String?, message: String?) -> AlertHandler {
			let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
			let handler = AlertHandler(alert: alert, from: self)
			return handler
		}

		func alert(title: String?, message: String?) -> AlertHandler {
			let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
			let handler = AlertHandler(alert: alert, from: self)
			return handler
		}

		final class AlertHandler {
			private weak var vc: UIViewController?
			private let alert: UIAlertController

			fileprivate init(alert: UIAlertController, from vc: UIViewController) {
				self.alert = alert
				self.vc = vc
			}

			public func addButton(_ title: String?, style: UIAlertAction.Style = .default, action: (() -> Void)?) -> AlertHandler {
				let alertAction = UIAlertAction(title: title, style: style) { _ in
					action?()
				}
				alert.addAction(alertAction)
				return self
			}

			public func present(completion: (() -> Void)? = nil) {
				vc?.present(alert, animated: true, completion: completion)
			}
		}
	}

#endif
