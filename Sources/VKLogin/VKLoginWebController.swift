//
//  VKLoginWebController.swift
//  MusicImport
//
//  Created by Daniil on 15.09.2019.
//  Copyright © 2019 Данил Войдилов. All rights reserved.
//

#if canImport(UIKit)
import UIKit
import WebKit
import SwiftHttp
import VKMusicAPI

open class VKLoginController: UIViewController, WKNavigationDelegate {
	
	open var client: VK.API = VK.API(client: UrlSessionHttpClient())
	open var hideOnLogin = false
	private(set) public lazy var webView = WKWebView()
	private var successLogin: (VKUser, _ webCookies: [String: String]) -> Void = { _, _ in }
	private var wasPreauthorized = false
	private var loadCount = 0
	
	public init(client: VK.API = VK.API(client: UrlSessionHttpClient()), successLogin: @escaping (VKUser, _ webCookies: [String: String]) -> Void) {
		super.init(nibName: nil, bundle: nil)
		self.successLogin = successLogin
		self.client = client
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	override open func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(webView)
		webView.frame = view.bounds
		webView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			webView.topAnchor.constraint(equalTo: view.topAnchor),
			webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
		webView.navigationDelegate = self
		webView.load(URLRequest(url: VK.API.baseURL.url))
		webView.allowsBackForwardNavigationGestures = true
		let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
		let refresh = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.reload))
		toolbarItems = [spacer, refresh]
		
		navigationController?.isToolbarHidden = toolbarItems?.isEmpty != false
		navigationController?.setNavigationBarHidden(true, animated: false)
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
	
	open func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
		if navigationAction.request.url?.absoluteString.hasSuffix("feed") == true {
			UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
				self.navigationController?.isToolbarHidden = true
				self.webView.alpha = 0
			})
		}
		decisionHandler(.allow)
	}
	
	open func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
		webView.evaluateJavaScript("document.documentElement.outerHTML.toString()", completionHandler: {[weak self] (html: Any?, error: Error?) in
			guard let self = self else { return }
			Task {
				let cookies = self.getCookies()
				self.client.webCookies = cookies
				let state = try await self.client.checkAuthorize()
				DispatchQueue.main.async {
					switch state {
					case .authorized(let user):
						if self.wasPreauthorized == true {
							self.successLogin(user, cookies)
							self.closeIfNeeded()
						} else {
							self.webView.alpha = 1
							self.useThisAccountSheet {
								self.successLogin(user, cookies)
								self.closeIfNeeded()
							}
						}
					case .preAuthorized:
						self.wasPreauthorized = true
					default:
						break
					}
					self.loadCount += 1
				}
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
		let cookies = URLSession.shared.configuration.httpCookieStorage?.cookies?.filter({ $0.name.contains("vk.com") }) ?? []
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
		
		public func addButton(_ title: String?, style: UIAlertAction.Style = .default, action: (() -> ())?) -> AlertHandler {
			let alertAction = UIAlertAction(title: title, style: style) { _ in
				action?()
			}
			alert.addAction(alertAction)
			return self
		}
		
		public func present(completion: (() -> ())? = nil) {
			vc?.present(alert, animated: true, completion: completion)
		}
	}
}

#endif
