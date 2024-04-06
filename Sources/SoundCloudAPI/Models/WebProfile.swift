import Foundation
import SwiftAPIClient

/** User's links added to their profile */
public typealias WebProfiles = [WebProfile]

public struct WebProfile: Codable, Equatable {
    
    public var created_at: Date?
    public var id: Int?
    public var title: String?
    public var url: String?
    public var username: String?
    public var kind: String?
    public var service: String?
    
    public init(created_at: Date? = nil, id: Int? = nil, title: String? = nil, url: String? = nil, username: String? = nil, kind: String? = nil, service: String? = nil) {
        self.created_at = created_at
        self.id = id
        self.title = title
        self.url = url
        self.username = username
        self.kind = kind
        self.service = service
    }
}
