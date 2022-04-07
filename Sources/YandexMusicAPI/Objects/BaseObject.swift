//
//  Response.swift
//  YandexAPI
//
//  Created by Daniil on 08.11.2019.
//  Copyright © 2019 Daniil. All rights reserved.
//

import Foundation

extension Yandex.Music.Objects {
    
    public struct Base<T: Encodable>: Encodable {
        public var ids: [String]
        public var object: T
        
        public enum CodingKeys: String, CodingKey {
            case ids = "_id_attrs"
        }
        
        public init(_ object: T, ids: [String] = []) {
            self.object = object
            self.ids = ids
        }
        
        //    public init(from decoder: Decoder) throws {
        //        object = try T.init(from: decoder)
        //        let container = try decoder.container(keyedBy: CodingKeys.self)
        //        ids = try container.decode([String].self, forKey: .ids)
        //    }
        
        public func encode(to encoder: Encoder) throws {
            try object.encode(to: encoder)
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(ids, forKey: .ids)
        }
        
    }

    public struct Result<T: Decodable>: Decodable {
        public let result: T
        public let invocationInfo: InvocationInfo?
    }
    
    public struct Results<T: Decodable>: Decodable {
        public let total: Int
        public let perPage: Int
        public let order: Int
        public let results: [T]
    }
    
    public struct InvocationInfo: Codable {
        public let hostname: String?
        public let requestId: String?
        private let execDurationMillis: String?
        public var executionDurationInMilliseconds: Int? {
            guard let str = execDurationMillis else { return nil }
            return Int(str)
        }
        
        public enum CodingKeys: String, CodingKey {
            case hostname, requestId = "req-id", execDurationMillis = "exec-duration-millis"
        }
    }
    
    public enum Visibility: String, Codable {
        case `public`
    }
    
    public enum Operation: String, Codable {
        case insert, delete
    }
    
}

extension YMO.Result: Encodable where T: Encodable {}
extension YMO.Results: Encodable where T: Encodable {}
