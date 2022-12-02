// Copyright (c) 2017 Spotify AB.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#if canImport(SafariServices) && canImport(UIKit)
	import Foundation
	import SafariServices
	import UIKit

	/// Use the login presenter to manually present the login authentication screen.
	public class SpotifyLoginPresenter {
		/// Trigger log in flow.
		///
		/// - Parameters:
		///   - scopes: A list of requested scopes and permissions.
		@discardableResult
		public class func login(scopes: [Scope], completion: @escaping (Error?) -> Void = { _ in }) -> UIViewController? {
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

		public class func canOpenSpotifyApp(scopes: [Scope], open: Bool, _ completion: @escaping (Error?) -> Void = { _ in }) -> Bool {
			SpotifyLogin.shared.onLogin = completion
			if let appAuthenticationURL = SpotifyLogin.shared.urlBuilder?.authenticationURL(type: .app, scopes: scopes),
			   UIApplication.shared.canOpenURL(appAuthenticationURL)
			{
				if open {
					UIApplication.shared.open(appAuthenticationURL, options: [:], completionHandler: nil)
				}
				return true
			}
			return false
		}
	}

	final class SafariViewController: SFSafariViewController {
		override func viewWillAppear(_ animated: Bool) {
			super.viewWillAppear(animated)
			navigationController?.setNavigationBarHidden(true, animated: true)
		}
	}
#endif
