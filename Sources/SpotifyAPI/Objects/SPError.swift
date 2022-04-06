public struct SPError: Codable {
   ///The HTTP status code (also returned in the response header; see [Response Status Codes](/documentation/web-api/#response-status-codes) for more information).
   public var status: Int
   ///A short description of the cause of the error.
   public var message: String
}