public struct SPPlayerError: Codable {
   ///The HTTP status code. Either 404 NOT FOUND or 403 FORBIDDEN. Also returned in the response header.
   public var status: Int
   ///A short description of the cause of the error.
   public var message: String
   ///One of the predefined [player error reasons](#player-error-reasons).
   public var reason: String
    
    public init(status: Int, message: String, reason: String) {
        self.status = status
        self.message = message
        self.reason = reason
    }
}
