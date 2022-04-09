//
//  File.swift
//  
//
//  Created by Данил Войдилов on 08.04.2022.
//

import Foundation

public struct VKPreAuthorizeParameters: Codable {
	public var ip: String
	public var lg: String
	
	public init(ip: String, lg: String) {
		self.ip = ip
		self.lg = lg
	}
}

public struct VKAuthorizeParameters: Codable {
	public var pre: VKPreAuthorizeParameters
	public var login: String
	public var password: String
	
	public init(pre: VKPreAuthorizeParameters, login: String, password: String) {
		self.pre = pre
		self.login = login
		self.password = password
	}
}

public struct VKAuthorizeAllParameters: Codable {
	public var act = VKAct.login
	public var role = "al_frame"
	public var ip_h: String
	public var lg_h: String
	public var email: String
	public var pass: String
	
	public init(act: VKAct = VKAct.login, role: String = "al_frame", ip_h: String, lg_h: String, email: String, pass: String) {
		self.act = act
		self.role = role
		self.ip_h = ip_h
		self.lg_h = lg_h
		self.email = email
		self.pass = pass
	}
}
