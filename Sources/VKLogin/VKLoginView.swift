//
//  File.swift
//  
//
//  Created by Данил Войдилов on 13.04.2022.
//

#if canImport(SwiftUI) && canImport(UIKit)
import Foundation
import SwiftUI
import VKMusicAPI
import SwiftHttp

public struct VKLoginView: UIViewControllerRepresentable {
	public var client: VK.API
	public var hideOnLogin: Bool
	public var successLogin: (VKUser, _ webCookies: [String: String]) -> Void
	
	public init(client: VK.API = VK.API(client: UrlSessionHttpClient()), hideOnLogin: Bool = true, successLogin: @escaping (VKUser, _ webCookies: [String: String]) -> Void = {_, _ in }) {
		self.successLogin = successLogin
		self.client = client
		self.hideOnLogin = hideOnLogin
	}

	public func makeUIViewController(context: Context) -> VKLoginController {
		VKLoginController(client: client, successLogin: successLogin)
	}
	
	public func updateUIViewController(_ uiViewController: VKLoginController, context: Context) {
		uiViewController.client = client
		uiViewController.successLogin = successLogin
		uiViewController.hideOnLogin = hideOnLogin
	}
}
#endif
