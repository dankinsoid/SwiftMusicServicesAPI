import Foundation

public enum VKAuthorizationState: Equatable, Codable, HTMLStringInitable {
    
	case authorized(user: VKUser), preAuthorized(VKPreAuthorizeParameters), none

	private struct Coding: Codable {
        
		var user: VKUser?
		var parameters: VKPreAuthorizeParameters?
	}

	public init(from decoder: Decoder) throws {
		let coding = try Coding(from: decoder)
		if let user = coding.user {
			self = .authorized(user: user)
		} else if let params = coding.parameters {
			self = .preAuthorized(params)
		} else {
			self = .none
		}
	}

	public func encode(to encoder: Encoder) throws {
		try Coding(user: user, parameters: parameters).encode(to: encoder)
	}

	public init(_ html: String) {
		if let id = Int(html.getParameter("vk_id") ?? "") {
			self = .authorized(user: VKUser(id: id))
		} else if let ip_h = html.getParameter("ip_h"), let lg_h = html.getParameter("lg_h") ?? html.getParameter("lg_domain_h") {
			self = .preAuthorized(VKPreAuthorizeParameters(ip: ip_h, lg: lg_h))
		} else {
			self = .none
		}
	}

	public init(htmlString html: String) throws {
		self.init(html)
	}

	public var isAuthorized: Bool {
		if case .authorized = self {
			return true
		}
		return false
	}

	public var user: VKUser? {
		if case let .authorized(user) = self {
			return user
		}
		return nil
	}

	public var parameters: VKPreAuthorizeParameters? {
		if case let .preAuthorized(parameters) = self {
			return parameters
		}
		return nil
	}

	public static func == (lhs: VKAuthorizationState, rhs: VKAuthorizationState) -> Bool {
		switch (lhs, rhs) {
		case let (.authorized(lUser), .authorized(rUser)): return lUser.id == rUser.id
		case (.preAuthorized, .preAuthorized): return true
		case (.none, .none): return true
		default: return false
		}
	}
}

extension String {
    
	func getParameter(_ par: String) -> String? {
		let ps = components(separatedBy: par + "=")
		if ps.count > 1 {
			return ps[1].components(separatedBy: "&").first
		}
		return nil
	}
}
