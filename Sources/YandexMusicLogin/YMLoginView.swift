//
//  File.swift
//  
//
//  Created by Данил Войдилов on 13.04.2022.
//

#if canImport(SwiftUI) && canImport(UIKit)
import Foundation
import SwiftUI
import YandexMusicAPI
import SwiftHttp

public struct YMLoginView: UIViewControllerRepresentable {
	public var api = YM.API(client: UrlSessionHttpClient())
	public var clientId = YM.API.clientID
	public var clientSecret = YM.API.clientSecret
	public var info = YMLoginInfo()
	public var hideOnLogin = false
	public var successLogin: (_ token: String, _ userID: Int) -> Void
	
	public init(
		api: YM.API = YM.API(client: UrlSessionHttpClient()),
		info: YMLoginInfo = YMLoginInfo(),
		clientId: String = YM.API.clientID,
		clientSecret: String = YM.API.clientSecret,
		hideOnLogin: Bool = true,
		successLogin: @escaping (_ token: String, _ userID: Int) -> Void = {_, _ in }
	) {
		self.api = api
		self.clientId = clientId
		self.clientSecret = clientSecret
		self.info = info
		self.hideOnLogin = hideOnLogin
		self.successLogin = successLogin
	}
	
	public func makeUIViewController(context: Context) -> YMLoginController {
		YMLoginController(api: api, info: info, clientId: clientId, clientSecret: clientSecret, successLogin: successLogin)
	}
	
	public func updateUIViewController(_ uiViewController: YMLoginController, context: Context) {
		uiViewController.api = api
		uiViewController.clientSecret = clientSecret
		uiViewController.clientId = clientId
		uiViewController.info = info
		uiViewController.successLogin = successLogin
		uiViewController.hideOnLogin = hideOnLogin
	}
}
#endif
