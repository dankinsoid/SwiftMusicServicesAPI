import Foundation
import SimpleCoders

public var safeDecodeArrayOnError: (Error, String) -> Void = { _, _ in }

@propertyWrapper
public struct SafeDecodeArray<Element>: RandomAccessCollection, MutableCollection, RangeReplaceableCollection, ExpressibleByArrayLiteral {

    public typealias Index = Int
    public typealias SubSequence = [Element].SubSequence
    public typealias Indices = [Element].Indices

    public var array: [Element]
    public var wrappedValue: [Element] {
        get { array }
        set { array = newValue }
    }

    public var startIndex: Int { array.startIndex }
    public var endIndex: Int { array.endIndex }

    public init<S: Sequence>(_ elements: S) where Element == S.Element {
        array = Array(elements)
    }

    public init() {
        array = []
    }

    public init(arrayLiteral elements: Element...) {
        array = elements
    }

    public subscript(position: Int) -> Element {
        get { array[position] }
        set { array[position] = newValue }
    }

    public subscript(bounds: Range<Int>) -> Array<Element>.SubSequence {
        get { array[bounds] }
        set { array[bounds] = newValue }
    }

    public mutating func replaceSubrange<C>(_ subrange: Range<Int>, with newElements: C) where C : Collection, Element == C.Element {
        array.replaceSubrange(subrange, with: newElements)
    }
}

extension SafeDecodeArray: Equatable where Element: Equatable {}
extension SafeDecodeArray: Hashable where Element: Hashable {}
extension SafeDecodeArray: Sendable where Element: Sendable {}

extension SafeDecodeArray: Decodable where Element: Decodable {

    public init(from decoder: Decoder) throws {
        array = try decodeArray {
            try decoder.unkeyedContainer()
        }
    }
}

extension SafeDecodeArray: Encodable where Element: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        for element in array {
            try? container.encode(element)
        }
    }
}

extension KeyedDecodingContainer {

    public func decodeIfPresent<T>(_ type: SafeDecodeArray<T>.Type, forKey key: Key) throws -> SafeDecodeArray<T>? where T: Decodable {
        if !contains(key) {
            return nil
        }
        return try SafeDecodeArray(
            decodeArray {
                try nestedUnkeyedContainer(forKey: key)
            }
        )
    }
}

private func decodeArray<T: Decodable>(unkeyedContainer: () throws -> UnkeyedDecodingContainer) throws -> [T] {
    var container: UnkeyedDecodingContainer
    do {
        container = try unkeyedContainer()
    } catch {
        return []
    }
    var fail: Error?
    var array: [T] = []
    var count = 0
    while !container.isAtEnd {
        count += 1
        let index = container.currentIndex
        do {
            try array.append(container.decode(T.self))
        } catch {
            if container.currentIndex == index {
                _ = try? container.nestedContainer(keyedBy: PlainCodingKey.self)
                if container.currentIndex == index {
                    throw error
                }
            }
            safeDecodeArrayOnError(error, error.humanReadable)
            if fail == nil {
                fail = error
            }
        }
    }
    if array.isEmpty, count > 0, let fail {
        throw fail
    }
    return array
}
