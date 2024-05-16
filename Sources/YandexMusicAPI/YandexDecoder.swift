import Foundation
import SimpleCoders
import SwiftHttp
import VDCodable

public extension Yandex {
    
    static var onWrongRevisionError: (_ expected: Int, _ actual: Int, String) -> Void = { _, _, _ in }
}

struct YandexDecoder: HttpDataDecoder {
    let decoder: VDJSONDecoder
    
    init() {
        let decoder = VDJSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase(separators: ["_", "-"])
        decoder.dateDecodingStrategy = ISO8601CodingStrategy()
        self.decoder = decoder
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
        //        try? print(JSON(from: data))
        do {
            return try decoder.decode(type, from: data)
        } catch {
            throw mapError(from: data) ?? error
        }
    }
    
    private func mapError(from data: Data) -> Error? {
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

struct WrongRevisionError: Error {
    let expected: Int
    let actual: Int
    let message: String
}
