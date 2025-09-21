#if canImport(SwiftUI) && canImport(UIKit)
	import Foundation
	import Logging
	import SwiftAPIClient
	import SwiftUI
	import VKMusicAPI

	public struct VKLoginView: UIViewControllerRepresentable {
		public var client: VK.API
		public var hideOnLogin: Bool
		public var successLogin: (VKUser, _ webCookies: [String: String]) -> Void

		public init(
			client: VK.API,
			hideOnLogin: Bool = true,
			successLogin: @escaping (VKUser, _ webCookies: [String: String]) -> Void = { _, _ in }
		) {
			self.successLogin = successLogin
			self.client = client
			self.hideOnLogin = hideOnLogin
		}

		public func makeUIViewController(context _: Context) -> VKLoginController {
			VKLoginController(client: client, successLogin: successLogin)
		}

		public func updateUIViewController(_ uiViewController: VKLoginController, context _: Context) {
			uiViewController.client = client
			uiViewController.successLogin = successLogin
			uiViewController.hideOnLogin = hideOnLogin
		}
	}
#endif
