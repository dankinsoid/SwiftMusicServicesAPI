import Foundation

extension Dictionary where Value: Equatable {
	func contains(_ other: Dictionary) -> Bool {
		!other.contains(where: { $0.value != self[$0.key] })
	}
}
