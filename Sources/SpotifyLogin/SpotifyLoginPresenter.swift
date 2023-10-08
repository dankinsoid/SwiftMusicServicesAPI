#if canImport(SafariServices) && canImport(UIKit)
	import Foundation
	import SafariServices
	import SpotifyAPI
	import UIKit

	/// Use the login presenter to manually present the login authentication screen.
	public class SpotifyLoginPresenter {

		public static var isSpotifyInstalled: Bool {
			UIApplication.shared.canOpenURL(
				URL(string: AuthenticationURLType.app.rawValue)!
			)
		}

		/// Trigger log in flow.
		///
		/// - Parameters:
		///   - scopes: A list of requested scopes and permissions.
		@discardableResult
		public class func login(
			scopes: [Scope],
			completion: @escaping (Result<SPTokenResponse, LoginError>) -> Void = { _ in }
		) -> UIViewController? {
			SpotifyLogin.shared.onLogin = completion
			let urlBuilder = SpotifyLogin.shared.urlBuilder
			if let appAuthenticationURL = urlBuilder?.authenticationURL(type: .app, scopes: scopes),
			   UIApplication.shared.canOpenURL(appAuthenticationURL)
			{
				UIApplication.shared.open(appAuthenticationURL, options: [:], completionHandler: nil)
			} else if let webAuthenticationURL = urlBuilder?.authenticationURL(type: .web, scopes: scopes) {
				return SafariViewController(url: webAuthenticationURL)
			}
			return nil
		}
	}

	final class SafariViewController: SFSafariViewController {
		override func viewWillAppear(_ animated: Bool) {
			super.viewWillAppear(animated)
			navigationController?.setNavigationBarHidden(true, animated: true)
		}
	}
#endif
