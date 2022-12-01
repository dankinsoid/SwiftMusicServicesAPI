import Foundation
import SwiftHttp

struct DecodableFailureDecoder: HttpDataDecoder {
    
    var decoder: HttpDataDecoder
    var decodeFailure: (Data) throws -> Error
    
    init(
        decoder: HttpDataDecoder,
        decodeFailure: @escaping (Data) throws -> Error
    ) {
        self.decoder = decoder
        self.decodeFailure = decodeFailure
    }
    
    init<Failure: Error & Decodable>(
    	_ type: Failure.Type,
    	decoder: HttpDataDecoder
    ) {
        self.init(decoder: decoder) {
            try decoder.decode(type, from: $0)
        }
    }
    
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        do {
            return try decoder.decode(type, from: data)
        } catch {
            if let failure = try? decodeFailure(data) {
                throw failure
            }
            throw error
        }
    }
}

public extension HttpDataDecoder {
    
    func decodeError(_ type: (some Decodable & Error).Type) -> HttpDataDecoder {
        DecodableFailureDecoder(type, decoder: self)
    }
}
