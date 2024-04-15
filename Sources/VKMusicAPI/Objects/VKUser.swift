import Foundation

public struct VKUser: Codable, Equatable, Identifiable, Hashable {

	public var id: Int
    public var hash: String?
    
    public init(id: Int, hash: String? = nil) {
        self.id = id
        self.hash = hash
    }
}
