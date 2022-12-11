#if canImport(SafariServices) && canImport(UIKit) && canImport(SwiftUI)
	import Combine
	import Foundation
	import SwiftUI
    import SpotifyAPI

	public struct SpotifyLoginView: View {
		public var scopes: [Scope]
		private var url: URL? {
			SpotifyLogin.shared.urlBuilder?.authenticationURL(type: .web, scopes: scopes)
		}

		public init(scopes: [Scope]) {
			self.scopes = scopes
		}

		public var body: some View {
			if let url {
				SafariView(url: url)
			}
		}
	}

	private struct SafariView: UIViewControllerRepresentable {
		let url: URL

		func makeUIViewController(context _: Context) -> SafariViewController {
			SafariViewController(url: url)
		}

		func updateUIViewController(_: SafariViewController, context _: Context) {}
	}

	public extension View {
		func onSpotifyLogin(_ success: @escaping () -> Void) -> some View {
			onReceive(NotificationCenter.default.publisher(for: .SpotifyLoginSuccessful)) { _ in
				success()
			}
		}
	}
#endif
