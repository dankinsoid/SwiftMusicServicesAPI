import Foundation

extension SoundCloud.Objects {

    public struct User: Identifiable, Equatable, Codable {
        
        public var id: String
        public var username: String?
        public var firstName: String?
        public var lastName: String?
        public var name: String?
        public var description: String?
        
        public var city: String?
        public var countryCode: String?
        
        public var followerCount: Int?
        public var followingCount: Int?
        public var trackCount: Int?
        public var avatarURL: URL?
        
        enum CodingKeys: String, CodingKey {

            case id
            case username
            case firstName = "first_name"
            case lastName = "last_name"
            case name = "full_name"
            case description = "description"
            case city = "city"
            case countryCode = "country_code"
            case followerCount = "followers_count"
            case followingCount = "followings_count"
            case trackCount = "trackCount"
            case avatarURL = "avatar_url"
        }
        
        public init(
            id: String,
            username: String? = nil,
            firstName: String? = nil,
            lastName: String? = nil,
            name: String? = nil,
            description: String? = nil,
            city: String? = nil,
            countryCode: String? = nil,
            followerCount: Int? = nil,
            followingCount: Int? = nil,
            trackCount: Int? = nil,
            avatarURL: URL? = nil
        ) {
            self.id = id
            self.username = username
            self.firstName = firstName
            self.lastName = lastName
            self.name = name
            self.description = description
            self.city = city
            self.countryCode = countryCode
            self.followerCount = followerCount
            self.followingCount = followingCount
            self.trackCount = trackCount
            self.avatarURL = avatarURL
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            // SoundCloud's API uses Int, Nuage uses String
            do {
                let rawID = try container.decode(Int.self, forKey: .id)
                id = String(rawID)
            }
            catch {
                id = try container.decode(String.self, forKey: .id)
            }
            
            username = try container.decodeIfPresent(String.self, forKey: .username)
            firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
            lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
            name = try container.decodeIfPresent(String.self, forKey: .name)
            description = try container.decodeIfPresent(String.self, forKey: .description)
            city = try container.decodeIfPresent(String.self, forKey: .city)
            countryCode = try container.decodeIfPresent(String.self, forKey: .countryCode)
            followerCount = try container.decodeIfPresent(Int.self, forKey: .followerCount)
            followingCount = try container.decodeIfPresent(Int.self, forKey: .followingCount)
            trackCount = try container.decodeIfPresent(Int.self, forKey: .trackCount)
            avatarURL = try container.decodeIfPresent(URL.self, forKey: .avatarURL)
        }
    }
}

public struct NoUserError: Error { }
