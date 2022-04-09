//
// Created by Данил Войдилов on 09.04.2022.
//

import Foundation

extension Dictionary where Value: Equatable {
	public func contains(_ other: Dictionary) -> Bool {
		!other.contains(where: { $0.value != self[$0.key] })
	}
}
