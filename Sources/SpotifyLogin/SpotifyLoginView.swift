//
//  SpotifyLoginView.swift
//  
//
//  Created by Данил Войдилов on 13.04.2022.
//

#if canImport(SafariServices) && canImport(UIKit) && canImport(SwiftUI)
import Foundation
import SwiftUI
import Combine

public struct SpotifyLoginView: View {
	public var scopes: [Scope]
	private var url: URL? {
		SpotifyLogin.shared.urlBuilder?.authenticationURL(type: .web, scopes: scopes)
	}
	
	public init(scopes: [Scope]) {
		self.scopes = scopes
	}
	
	public var body: some View {
		if let url = url {
			SafariView(url: url)
		}
	}
}

private struct SafariView: UIViewControllerRepresentable {
	let url: URL
	
	func makeUIViewController(context: Context) -> SafariViewController {
		SafariViewController(url: url)
	}
	
	func updateUIViewController(_ uiViewController: SafariViewController, context: Context) {}
}

extension View {
	public func onSpotifyLogin(_ success: @escaping () -> Void) -> some View {
		onReceive(NotificationCenter.default.publisher(for: .SpotifyLoginSuccessful)) { _ in
			success()
		}
	}
}
#endif
