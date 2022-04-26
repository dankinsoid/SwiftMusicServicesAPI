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
		
		public enum CodingKeys: String, CodingKey, CaseIterable {
			case ids = "_id_attrs"
		}
		
		public init(_ object: T, ids: [String] = []) {
			self.object = object
			self.ids = ids
		}
		
		//    public init(from decoder: Decoder) throws {
		//        object = try T.init(from: decoder)
		//        var container = try decoder.container(keyedBy: CodingKeys.self)
		//        ids = try container.decode([String].self, forKey: .ids)
		//    }
		
		public func encode(to encoder: Encoder) throws {
			try object.encode(to: encoder)
			var container = encoder.container(keyedBy: CodingKeys.self)
			try container.encode(ids, forKey: .ids)
		}
		
	}
	
	public struct Result<T: Decodable>: Decodable {
		public var result: T
		public var invocationInfo: InvocationInfo?
	}
	
	public struct Results<T: Decodable>: Decodable {
		public var total: Int
		public var perPage: Int
		public var order: Int
		public var results: [T]
	}
	
	public struct InvocationInfo: Codable {
		public init(hostname: String? = nil, requestId: String? = nil, execDurationMillis: String? = nil) {
			self.hostname = hostname
			self.requestId = requestId
			self.execDurationMillis = execDurationMillis
		}
		
		public var hostname: String?
		public var requestId: String?
		private var execDurationMillis: String?
		public var executionDurationInMilliseconds: Int? {
			guard let str = execDurationMillis else { return nil }
			return Int(str)
		}
		
		public enum CodingKeys: String, CodingKey, CaseIterable {
			case hostname, requestId = "req-id", execDurationMillis = "exec-duration-millis"
		}
	}
	
	public enum Visibility: String, Codable, CaseIterable {
		case `public`
	}
	
	public enum Operation: String, Codable, CaseIterable {
		case insert, delete
	}
	
}

extension YMO.Result: Encodable where T: Encodable {}
extension YMO.Results: Encodable where T: Encodable {}
