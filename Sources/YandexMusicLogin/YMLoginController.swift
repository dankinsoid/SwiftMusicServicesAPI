#if canImport(UIKit)
	import SwiftHttp
	import UIKit
	import VDCodable
	import WebKit
	import YandexMusicAPI
    import Logging

	open class YMLoginController: UIViewController, WKNavigationDelegate {
        open var api = YM.API(client: UrlSessionHttpClient(logLevel: .debug))
		open var clientId = YM.API.clientID
		open var clientSecret = YM.API.clientSecret
		open var info = YMLoginInfo()
		open var hideOnLogin = false
		open var tokenBySessionIDQuery = YM.API.TokenBySessionIDQuery()
		open private(set) lazy var webView = WKWebView()
		open var successLogin: (_ token: String, _ userID: Int) -> Void = { _, _ in }
		private var trackID: String?
		private var needRequest = true
		private var _yasc: String?

		public init(
			api: YM.API = YM.API(client: UrlSessionHttpClient(logLevel: .debug)),
			info: YMLoginInfo = YMLoginInfo(),
			clientId: String = YM.API.clientID,
			clientSecret: String = YM.API.clientSecret,
			successLogin: @escaping (_ token: String, _ userID: Int) -> Void = { _, _ in }
		) {
			super.init(nibName: nil, bundle: nil)
			self.api = api
			self.clientId = clientId
			self.clientSecret = clientSecret
			self.info = info
			self.successLogin = successLogin

			tokenBySessionIDQuery = YM.API.TokenBySessionIDQuery(
				app_id: info.app_id,
				uuid: info.uuid,
				ifv: YM.API.ifv,
				am_version_name: info.am_version_name,
				deviceid: info.device_id,
				device_name: info.device_name,
				device_id: info.device_id,
				app_platform: info.app_platform
			)
		}

		public required init?(coder aDecoder: NSCoder) {
			super.init(coder: aDecoder)
		}

		override public func viewDidLoad() {
			super.viewDidLoad()
			view.addSubview(webView)

			webView.frame = view.bounds
			webView.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
				webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
				webView.topAnchor.constraint(equalTo: view.topAnchor),
				webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
			])
			webView.navigationDelegate = self
			webView.backgroundColor = #colorLiteral(red: 0.074509345, green: 0.07451017946, blue: 0.09161251038, alpha: 1)
			//		webView.isOpaque = false
			webView.scrollView.indicatorStyle = .default

			let url = try! URLQueryEncoder().encode(info, for: YM.API.passportURL.url)
			var request = URLRequest(url: url)
			request.addValue("passport.yandex.com", forHTTPHeaderField: "Host")
			webView.load(request)
			webView.allowsBackForwardNavigationGestures = true
			view.backgroundColor = .clear
		}

		override public func viewWillAppear(_ animated: Bool) {
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

		public func webView(_: WKWebView, didFinish _: WKNavigation!) {}

		public func webView(_ webView: WKWebView, decidePolicyFor _: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
			guard needRequest, webView.url?.absoluteString == "https://passport.yandex.com/profile" else {
				decisionHandler(.allow)
				return
			}
			webView.configuration.websiteDataStore.httpCookieStore.getAllCookies { [self] cookies in
				if let cookie = cookies.first(where: { $0.name == "_yasc" }) {
					_yasc = cookie.value
				}
				needRequest = false
				Task {
					do {
						let tokenBySession = try await api.tokenBySessionID(
							cookies: cookies.map { ($0.name, $0.value) },
							track_id: self.trackID,
							info: tokenBySessionIDQuery
						)
						let passportToken = try await api.passportToken(
							clientId: clientId,
							clientSecret: clientSecret,
							accessToken: tokenBySession.accessToken,
							_yasc: _yasc ?? "",
							info: tokenBySessionIDQuery
						)
						DispatchQueue.main.async { [self] in
							api.token = passportToken.accessToken
							successLogin(passportToken.accessToken, passportToken.uid ?? 0)
							closeIfNeeded()
							decisionHandler(.cancel)
						}
					} catch {
						DispatchQueue.main.async {
							decisionHandler(.cancel)
						}
					}
				}
			}
		}
	}

	public extension YM.API.TokenBySessionIDQuery {
		init() {
			self = YM.API.TokenBySessionIDQuery(
				deviceid: UIDevice.current.identifierForVendor ?? UUID(),
				device_name: UIDevice.current.name,
				device_id: UIDevice.current.identifierForVendor ?? UUID()
			)
		}
	}

	public struct YMLoginInfo: Codable {
		public var app_platform = "ios"
		public var app_id = "ru.yandex.mobile.music"
		public var app_version = "104199"
		public var am_version_name = "6.6.1"
		public var device_id = UIDevice.current.identifierForVendor ?? UUID() // "FBF6FE07-938F-43D6-8EC1-301A1FFD2D94"
		public var scheme = "yandexmusic"
		public var theme = "dark"
		public var lang = Locale.current.languageCode ?? "en" // "en"
		public var locale = Locale.current.identifier // "en"
		public var source = ""
		public var mode = "welcome"
		public var reg_type = "neophonish"
		public var device_name = UIDevice.current.name
		public var auth_type = "lite,social,yandex"
		public var siwa = true
		public var uuid = Yandex.Music.API.uuid

		public init(
			app_platform: String = "ios",
			app_id: String = "ru.yandex.mobile.music",
			app_version: String = "104199",
			am_version_name: String = "6.6.1",
			device_id: UUID = UIDevice.current.identifierForVendor ?? UUID(),
			scheme: String = "yandexmusic",
			theme: String = "dark",
			lang: String = Locale.current.languageCode ?? "en",
			locale: String = Locale.current.identifier,
			source: String = "",
			mode: String = "welcome",
			reg_type: String = "neophonish",
			device_name: String = UIDevice.current.name,
			auth_type: String = "lite,social,yandex",
			siwa: Bool = true,
			uuid: String = Yandex.Music.API.uuid
		) {
			self.app_platform = app_platform
			self.app_id = app_id
			self.app_version = app_version
			self.am_version_name = am_version_name
			self.device_id = device_id
			self.scheme = scheme
			self.theme = theme
			self.lang = lang
			self.locale = locale
			self.source = source
			self.mode = mode
			self.reg_type = reg_type
			self.device_name = device_name
			self.auth_type = auth_type
			self.siwa = siwa
			self.uuid = uuid
		}
	}
#endif
