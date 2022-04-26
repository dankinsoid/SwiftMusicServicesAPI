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
}

public struct VKAuthorizeParameters: Codable {
	public var pre: VKPreAuthorizeParameters
	public var login: String
	public var password: String
}

public struct VKAuthorizeAllParameters: Codable {
	public var act = VKAct.login
	public var role = "al_frame"
	public var ip_h: String
	public var lg_h: String
	public var email: String
	public var pass: String
}
