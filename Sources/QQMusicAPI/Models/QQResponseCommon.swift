import Foundation

public struct QQResponseCommon: Decodable, LocalizedError {

    /// error code
    public var ret: QQStatusCode
    /// sub_ret. Logical error codes for business downstream calls.
    public var subRet: QQStatusCode?
    /// Specific reason for request failure
    public var msg: String?
    /// User login state verification result 0: Not transmitted or verification successful 1: User state verification failed
    public var vcheck: VCheck?
    /// trace_id. Link trace_id, used for QQ music side association requests, listening to music streaming reports also need to be passed
    public var traceID: String?

    public var errorDescription: String? { msg }
    
    public init(
        ret: QQStatusCode,
        subRet: QQStatusCode? = nil,
        msg: String? = nil,
        vcheck: VCheck? = nil,
        traceID: String? = nil
    ) {
        self.ret = ret
        self.subRet = subRet
        self.msg = msg
        self.vcheck = vcheck
        self.traceID = traceID
    }
    
    public enum CodingKeys: String, CodingKey {

        case ret
        case subRet = "sub_ret"
        case msg
        case vcheck
        case traceID = "trace_id"
    }
}
