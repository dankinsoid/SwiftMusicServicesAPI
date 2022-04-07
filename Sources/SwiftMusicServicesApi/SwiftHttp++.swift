//
// Created by Данил Войдилов on 06.04.2022.
//

import Foundation
import SwiftHttp
import VDCodable

extension HttpUrl {

	public func query<T: Encodable>(from query: T, encoder: URLQueryEncoder = .init()) throws -> HttpUrl {
		try self.query(encoder.encodeParameters(query))
	}
}