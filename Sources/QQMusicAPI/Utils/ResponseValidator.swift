import Foundation
import SwiftAPIClient

extension HTTPResponseValidator {

    public static let qq = HTTPResponseValidator { _, data, configs in
        let common = try configs.bodyDecoder.decode(QQResponseCommon.self, from: data)
        guard common.ret == .success else {
            throw common
        }
    }
}
