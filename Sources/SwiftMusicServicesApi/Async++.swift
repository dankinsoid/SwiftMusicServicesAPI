import Foundation

extension AsyncSequence where Element: Collection {

	public func collect() async throws -> [Element.Element] {
		try await reduce([], +)
	}
}
