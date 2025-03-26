import Foundation
import SimpleCoders

final class InsertPartsEncoder {

	fileprivate var parts: [String] = []
	fileprivate var type: Encodable.Type = Int.self

	init() {}

	func parts<K: RawRepresentable, T: Encodable>(of value: T, as _: K.Type) -> [K] where K.RawValue == String {
		type = T.self
		parts = []
		try? _InsertPartsEncoder(encoder: self, type: T.self).encode(value)
		return parts.compactMap { K(rawValue: $0) }
	}
}

private struct _InsertPartsEncoder: Encoder {

	var codingPath: [CodingKey] = []
	let encoder: InsertPartsEncoder
	var userInfo: [CodingUserInfoKey: Any] = [:]
	var type: Any.Type

	func container<Key>(keyedBy type: Key.Type) -> KeyedEncodingContainer<Key> where Key: CodingKey {
		KeyedEncodingContainer(KeyedContainer(encoder: self))
	}

	func unkeyedContainer() -> UnkeyedEncodingContainer {
		UnkeyedContainer(encoder: self)
	}

	func singleValueContainer() -> SingleValueEncodingContainer {
		SingleContainer(encoder: self)
	}

	func encode(_ value: Encodable) throws {
		try value.encode(to: self)
	}

	func addPart(_ key: CodingKey) {
		guard encoder.type == type else { return }
		encoder.parts.append(key.stringValue)
	}
}

private struct SingleContainer: SingleValueEncodingContainer {

	let encoder: _InsertPartsEncoder
	var codingPath: [CodingKey] { encoder.codingPath }

	mutating func encodeNil() throws {}
	mutating func encode(_: Bool) throws {}
	mutating func encode(_: String) throws {}
	mutating func encode(_: Double) throws {}
	mutating func encode(_: Float) throws {}
	mutating func encode(_: Int) throws {}
	mutating func encode(_: Int8) throws {}
	mutating func encode(_: Int16) throws {}
	mutating func encode(_: Int32) throws {}
	mutating func encode(_: Int64) throws {}
	mutating func encode(_: UInt) throws {}
	mutating func encode(_: UInt8) throws {}
	mutating func encode(_: UInt16) throws {}
	mutating func encode(_: UInt32) throws {}
	mutating func encode(_: UInt64) throws {}
	mutating func encode<T>(_ value: T) throws where T: Encodable {
		try _InsertPartsEncoder(codingPath: codingPath, encoder: encoder.encoder, type: T.self).encode(value)
	}
}

private struct UnkeyedContainer: UnkeyedEncodingContainer {

	var count = 0
	let encoder: _InsertPartsEncoder
	var codingPath: [CodingKey] { encoder.codingPath }

	mutating func encodeNil() throws { count += 1 }
	mutating func encode(_: Bool) throws { count += 1 }
	mutating func encode(_: String) throws { count += 1 }
	mutating func encode(_: Double) throws { count += 1 }
	mutating func encode(_: Float) throws { count += 1 }
	mutating func encode(_: Int) throws { count += 1 }
	mutating func encode(_: Int8) throws { count += 1 }
	mutating func encode(_: Int16) throws { count += 1 }
	mutating func encode(_: Int32) throws { count += 1 }
	mutating func encode(_: Int64) throws { count += 1 }
	mutating func encode(_: UInt) throws { count += 1 }
	mutating func encode(_: UInt8) throws { count += 1 }
	mutating func encode(_: UInt16) throws { count += 1 }
	mutating func encode(_: UInt32) throws { count += 1 }
	mutating func encode(_: UInt64) throws { count += 1 }
	mutating func nestedUnkeyedContainer() -> UnkeyedEncodingContainer {
		count += 1
		let path = codingPath + [PlainCodingKey(intValue: count - 1)].compactMap { $0 }
		return UnkeyedContainer(
			encoder: _InsertPartsEncoder(codingPath: path, encoder: encoder.encoder, type: [Any].self)
		)
	}

	mutating func superEncoder() -> any Encoder {
		encoder
	}

	mutating func encode<T>(_ value: T) throws where T: Encodable {
		count += 1
		try _InsertPartsEncoder(encoder: encoder.encoder, type: T.self).encode(value)
	}

	mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
		count += 1
		let path = codingPath + [PlainCodingKey(intValue: count - 1)].compactMap { $0 }
		return KeyedEncodingContainer(
			KeyedContainer(
				encoder: _InsertPartsEncoder(codingPath: path, encoder: encoder.encoder, type: [Any].self)
			)
		)
	}
}

private struct KeyedContainer<Key: CodingKey>: KeyedEncodingContainerProtocol {

	let encoder: _InsertPartsEncoder
	var codingPath: [CodingKey] { encoder.codingPath }

	mutating func encodeNil(forKey key: Key) throws {}
	mutating func encode(_ value: Bool, forKey key: Key) throws { encoder.addPart(key) }
	mutating func encode(_ value: String, forKey key: Key) throws { encoder.addPart(key) }
	mutating func encode(_ value: Double, forKey key: Key) throws { encoder.addPart(key) }
	mutating func encode(_ value: Float, forKey key: Key) throws { encoder.addPart(key) }
	mutating func encode(_ value: Int, forKey key: Key) throws { encoder.addPart(key) }
	mutating func encode(_ value: Int8, forKey key: Key) throws { encoder.addPart(key) }
	mutating func encode(_ value: Int16, forKey key: Key) throws { encoder.addPart(key) }
	mutating func encode(_ value: Int32, forKey key: Key) throws { encoder.addPart(key) }
	mutating func encode(_ value: Int64, forKey key: Key) throws { encoder.addPart(key) }
	mutating func encode(_ value: UInt, forKey key: Key) throws { encoder.addPart(key) }
	mutating func encode(_ value: UInt8, forKey key: Key) throws { encoder.addPart(key) }
	mutating func encode(_ value: UInt16, forKey key: Key) throws { encoder.addPart(key) }
	mutating func encode(_ value: UInt32, forKey key: Key) throws { encoder.addPart(key) }
	mutating func encode(_ value: UInt64, forKey key: Key) throws { encoder.addPart(key) }
	mutating func encode<T>(_ value: T, forKey key: Key) throws where T: Encodable {
		encoder.addPart(key)
		try _InsertPartsEncoder(codingPath: codingPath + [key], encoder: encoder.encoder, type: T.self)
			.encode(value)
	}

	mutating func nestedContainer<NestedKey>(keyedBy keyType: NestedKey.Type, forKey key: Key) -> KeyedEncodingContainer<NestedKey> where NestedKey: CodingKey {
		encoder.addPart(key)
		return KeyedEncodingContainer(
			KeyedContainer<NestedKey>(
				encoder: _InsertPartsEncoder(codingPath: codingPath + [key], encoder: encoder.encoder, type: [String: Any].self)
			)
		)
	}

	mutating func nestedUnkeyedContainer(forKey key: Key) -> any UnkeyedEncodingContainer {
		encoder.addPart(key)
		return UnkeyedContainer(
			encoder: _InsertPartsEncoder(codingPath: codingPath + [key], encoder: encoder.encoder, type: [Any].self)
		)
	}

	mutating func superEncoder() -> any Encoder {
		encoder
	}

	mutating func superEncoder(forKey key: Key) -> any Encoder {
		encoder.addPart(key)
		return _InsertPartsEncoder(codingPath: codingPath + [key], encoder: encoder.encoder, type: [String: Any].self)
	}
}
