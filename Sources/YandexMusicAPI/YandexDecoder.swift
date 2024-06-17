import Foundation
import SimpleCoders
import SwiftAPIClient
import VDCodable

public extension Yandex {
    
    static var onWrongRevisionError: (_ expected: Int, _ actual: Int, String) -> Void = { _, _, _ in }
}

struct YandexDecoder: DataDecoder {

    let decoder: VDJSONDecoder
    let isAuthorized: Bool
    
    init(isAuthorized: Bool = true) {
        let decoder = VDJSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase(separators: ["_", "-"])
        decoder.dateDecodingStrategy = ISO8601CodingStrategy()
        self.decoder = decoder
        self.isAuthorized = isAuthorized
    }
    
    ///
    /// Decodes the response data into a custom decodable object
    ///
    /// - Parameter type: The type of the decodable object
    /// - Parameter data: The HttpResponse data
    ///
    /// - Throws: `Error` if something was wrong with the decoding
    ///
    /// - Returns: The decoded object
    ///
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        if isAuthorized {
            return try decoder.decode(YMO.Result<T>.self, from: data).result
        } else {
            return try decoder.decode(type, from: data)
        }
    }
}

extension ErrorDecoder {
    
    public static var yandexMusic: ErrorDecoder {
        ErrorDecoder { data, _ in
            if let string = String(data: data, encoding: .utf8)?.lowercased() {
                let pattern = #"expected ?revision: ?(\d+).*actual ?revision: ?(\d+)"#
                if let regex = try? NSRegularExpression(pattern: pattern, options: [.caseInsensitive]) {
                    let matches = regex.matches(in: string, options: [], range: NSRange(location: 0, length: string.count))
                    if let match = matches.first {
                        if let expected = Int((string as NSString).substring(with: match.range(at: 1))),
                           let actual = Int((string as NSString).substring(with: match.range(at: 2))) {
                            Yandex.onWrongRevisionError(expected, actual, string)
                            return WrongRevisionError(expected: expected, actual: actual, message: string)
                        }
                    }
                }
            }
            
            if let err = try? VDJSONDecoder().decode(YandexError.self, from: data) {
                return err
            } else if let err = try? VDJSONDecoder().decode(YandexFailure.self, from: data) {
                return err
            } else {
                return nil
            }
        }
    }
}

struct WrongRevisionError: Error {
    let expected: Int
    let actual: Int
    let message: String
}
