//
//  Common.swift
//  YandexAPI
//
//  Created by Daniil on 27.11.2019.
//  Copyright © 2019 Daniil. All rights reserved.
//

import Foundation

@propertyWrapper
public enum RawEnum<T: RawRepresentable>: RawRepresentable {
    case `case`(T), raw(T.RawValue)
    
    public var rawValue: T.RawValue {
        get {
            switch self {
            case .case(let enu):    return enu.rawValue
            case .raw(let raw):     return raw
            }
        }
        set {
            self = RawEnum(newValue)
        }
    }

    public var projectedValue: T? {
        get { asEnum }
        set { self = newValue.map { .case($0) } ?? self }
    }

    public var wrappedValue: T.RawValue {
        get { rawValue }
        set { rawValue = newValue }
    }
    
    public var asEnum: T? {
        switch self {
        case .case(let enu):    return enu
        case .raw:              return nil
        }
    }
    
    public init(_ rawValue: T.RawValue) {
        if let value = T.init(rawValue: rawValue) {
            self = .case(value)
        } else {
            self = .raw(rawValue)
        }
    }
    
    public init?(rawValue: T.RawValue) {
        self = RawEnum(rawValue)
    }

    public init(wrappedValue: T.RawValue) {
        self = RawEnum(wrappedValue)
    }

    public init(_ enumValue: T) {
        self = .case(enumValue)
    }
}

extension RawEnum: Decodable where T.RawValue: Decodable {
    
    public init(from decoder: Decoder) throws {
        let rawValue = try T.RawValue.init(from: decoder)
        self = RawEnum(rawValue)
    }
    
}

extension RawEnum: Encodable where T.RawValue: Encodable {
    
    public func encode(to encoder: Encoder) throws {
        try rawValue.encode(to: encoder)
    }
}

extension RawEnum: Equatable where T.RawValue: Equatable {}
extension RawEnum: Hashable where T.RawValue: Hashable {}
