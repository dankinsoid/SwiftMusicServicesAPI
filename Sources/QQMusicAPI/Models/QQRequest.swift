import Foundation

public struct QQRequestCommon: Encodable {

    /// Music assigned app_id
    public var appID: String
    /// The business party generates a signed unix timestamp
    public var timestamp: Date
    /// Data signature
    public var sign: String
    /// The real client IP is not allowed to be passed to the internal network IP.
    public var clientIP: String
    /// API command words
    public var opiCmd: String

    public init(appID: String, timestamp: Date = Date(), sign: String, clientIP: String, opiCmd: String) {
        self.appID = appID
        self.timestamp = timestamp
        self.sign = sign
        self.clientIP = clientIP
        self.opiCmd = opiCmd
    }

    public enum CodingKeys: String, CodingKey {
        case appID = "app_id"
        case timestamp
        case sign
        case clientIP = "client_ip"
        case opiCmd = "opi_cmd"
    }
}

