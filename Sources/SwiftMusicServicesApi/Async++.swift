import Foundation

public extension AsyncSequence where Element: Collection {
	func collect() async throws -> [Element.Element] {
		try await reduce([], +)
	}
}
