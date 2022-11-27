public struct SPCopyright: Codable {
   ///The copyright text for this album.
   public var text: String
   ///The type of copyright: C = the copyright, P = the sound recording (performance) copyright.
   public var type: String
    
    public init(text: String, type: String) {
        self.text = text
        self.type = type
    }
}
