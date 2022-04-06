//
// Created by Данил Войдилов on 06.04.2022.
//

import Foundation
import SwiftHttp
import VDCodable

extension HttpUrl {

	public init?(string: String) {
		if let url = URL(string: string) {
			self.init(url: url)
		} else {
			return nil
		}
	}

	public init?(url: URL) {
		guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
		var path = components.path.trimmingCharacters(in: CharacterSet(charactersIn: "/")).components(separatedBy: "/")
		let resource: String?
		if path.last?.contains(".") == true {
			resource = path.removeLast()
		} else {
			resource = nil
		}
		self.init(
				scheme: components.scheme ?? "https",
				host: components.host ?? "",
				port: components.port ?? 80,
				path: path,
				resource: resource,
				query: components.queryItems.map({ Dictionary($0.map({ ($0.name, $0.value ?? "") })) { _, s in s } }) ?? [:],
				fragment: components.fragment
		)
	}

	public func query<T: Encodable>(from query: T, encoder: URLQueryEncoder = .init()) throws -> HttpUrl {
		try self.query(encoder.encodeParameters(query))
	}
}