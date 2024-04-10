import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

extension QQMusic.API {

    public var authModifier: AuthModifier {
        AuthModifier { [appID, appKey, appPrivateKey] req, configs in
            let timestamp = Date().timeIntervalSince1970
            if let appPrivateKey {
                let signString = "OpitrtqeGzopIlwxs_\(appID)_\(appKey)_\(appPrivateKey)_\(timestamp)"
                let sign = MD5(signString)
            } else {
                
            }
            let items = try configs.queryEncoder.encode(<#T##value: Encodable##Encodable#>)
            
        }
    }
}
