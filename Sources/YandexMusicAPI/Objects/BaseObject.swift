import Foundation
import SwiftMusicServicesApi

public extension Yandex.Music.Objects {
	struct Base<T: Encodable>: Encodable {
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

	struct Result<T: Decodable>: Decodable {
		public var result: T
		public var invocationInfo: InvocationInfo?
	}

	struct Results<T: Decodable>: Decodable {
		public var total: Int
		public var perPage: Int
		public var order: Int
		@SafeDecodeArray public var results: [T]
        
        public init(total: Int, perPage: Int, order: Int, results: [T]) {
            self.total = total
            self.perPage = perPage
            self.order = order
            self._results = SafeDecodeArray(results)
        }
	}

	struct InvocationInfo: Codable {

		public init(hostname: String? = nil, requestId: String? = nil, execDurationMillis: String? = nil) {
			self.hostname = hostname
			self.requestId = requestId
//			self.execDurationMillis = execDurationMillis
		}

		public var hostname: String?
		public var requestId: String?
//		private var execDurationMillis: String?

//		public var executionDurationInMilliseconds: Int? {
//			guard let str = execDurationMillis else { return nil }
//			return Int(str)
//		}

		public enum CodingKeys: String, CodingKey, CaseIterable {
			case hostname, requestId = "req-id" // , execDurationMillis = "exec-duration-millis"
		}
	}

	enum Visibility: String, Codable, CaseIterable {
		case `public`, unknown

		public init(from decoder: Decoder) throws {
			self = try Self(rawValue: String(from: decoder)) ?? .unknown
		}
	}

	enum Operation: String, Codable, CaseIterable {
		case insert, delete, unknown

		public init(from decoder: Decoder) throws {
			self = try Self(rawValue: String(from: decoder)) ?? .unknown
		}
	}
}

extension YMO.Result: Encodable where T: Encodable {}
extension YMO.Results: Encodable where T: Encodable {}
