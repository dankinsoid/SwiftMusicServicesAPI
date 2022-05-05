//
// Created by Данил Войдилов on 06.04.2022.
//

import Foundation

extension AsyncSequence where Element: Collection {

	public func collect() async throws -> [Element.Element] {
		try await reduce([], +)
	}
}
