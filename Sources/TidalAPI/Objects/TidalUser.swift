import Foundation

extension Tidal.Objects {

    public struct User: Equatable, Codable, Identifiable {

        public var id: Int
        public var email: String?
        public var countryCode: String?
        public var fullName: String?
        public var firstName: String?
        public var lastName: String?
        public var nickname: String?
        public var username: String?
        public var address: String?
        public var city: String?
        public var postalcode: String?
        public var usState: String?
        public var phoneNumber: String?
        public var birthday: String?
        public var gender: String?
        public var imageId: String?
        public var channelId: Int?
        public var parentId: Int?
        public var acceptedEULA: Bool?
        public var created: Date?
        public var updated: Date?
        public var facebookUid: Int?
        public var appleUid: String?
        public var newUser: Bool?
        public var picture: String?
        public var newsletter: Bool?
        public var dateOfBirth: Date?
        private var userId: Int?
        
        public init(
            id: Int,
            email: String? = nil,
            countryCode: String? = nil,
            fullName: String? = nil,
            firstName: String? = nil,
            lastName: String? = nil,
            nickname: String? = nil,
            username: String? = nil,
            address: String? = nil,
            city: String? = nil,
            postalcode: String? = nil,
            usState: String? = nil,
            phoneNumber: String? = nil,
            birthday: String? = nil,
            gender: String? = nil,
            imageId: String? = nil,
            channelId: Int? = nil,
            parentId: Int? = nil,
            acceptedEULA: Bool? = nil,
            created: Date? = nil,
            updated: Date? = nil,
            facebookUid: Int? = nil,
            appleUid: String? = nil,
            newUser: Bool? = nil,
            picture: String? = nil,
            newsletter: Bool? = nil,
            dateOfBirth: Date? = nil
        ) {
            self.id = id
            self.email = email
            self.countryCode = countryCode
            self.fullName = fullName
            self.firstName = firstName
            self.lastName = lastName
            self.nickname = nickname
            self.username = username
            self.address = address
            self.city = city
            self.postalcode = postalcode
            self.usState = usState
            self.phoneNumber = phoneNumber
            self.birthday = birthday
            self.gender = gender
            self.imageId = imageId
            self.channelId = channelId
            self.parentId = parentId
            self.acceptedEULA = acceptedEULA
            self.created = created
            self.updated = updated
            self.facebookUid = facebookUid
            self.appleUid = appleUid
            self.newUser = newUser
            self.picture = picture
            self.newsletter = newsletter
            self.dateOfBirth = dateOfBirth
        }
        
        public init(from decoder: any Decoder) throws {
            let container: KeyedDecodingContainer<CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
            self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? container.decode(Int.self, forKey: .userId)
            self.email = try container.decodeIfPresent(String.self, forKey: .email)
            self.countryCode = try container.decodeIfPresent(String.self, forKey: .countryCode)
            self.fullName = try container.decodeIfPresent(String.self, forKey: .fullName)
            self.firstName = try container.decodeIfPresent(String.self, forKey: .firstName)
            self.lastName = try container.decodeIfPresent(String.self, forKey: .lastName)
            self.nickname = try container.decodeIfPresent(String.self, forKey: .nickname)
            self.username = try container.decodeIfPresent(String.self, forKey: .username)
            self.address = try container.decodeIfPresent(String.self, forKey: .address)
            self.city = try container.decodeIfPresent(String.self, forKey: .city)
            self.postalcode = try container.decodeIfPresent(String.self, forKey: .postalcode)
            self.usState = try container.decodeIfPresent(String.self, forKey: .usState)
            self.phoneNumber = try container.decodeIfPresent(String.self, forKey: .phoneNumber)
            self.birthday = try container.decodeIfPresent(String.self, forKey: .birthday)
            self.gender = try container.decodeIfPresent(String.self, forKey: .gender)
            self.imageId = try container.decodeIfPresent(String.self, forKey: .imageId)
            self.channelId = try container.decodeIfPresent(Int.self, forKey: .channelId)
            self.parentId = try container.decodeIfPresent(Int.self, forKey: .parentId)
            self.acceptedEULA = try container.decodeIfPresent(Bool.self, forKey: .acceptedEULA)
            self.created = try container.decodeIfPresent(Date.self, forKey: .created)
            self.updated = try container.decodeIfPresent(Date.self, forKey: .updated)
            self.facebookUid = try container.decodeIfPresent(Int.self, forKey: .facebookUid)
            self.appleUid = try container.decodeIfPresent(String.self, forKey: .appleUid)
            self.newUser = try container.decodeIfPresent(Bool.self, forKey: .newUser)
            self.picture = try container.decodeIfPresent(String.self, forKey: .picture)
            self.newsletter = try container.decodeIfPresent(Bool.self, forKey: .newsletter)
            self.dateOfBirth = try container.decodeIfPresent(Date.self, forKey: .dateOfBirth)
            self.userId = try container.decodeIfPresent(Int.self, forKey: .userId)
        }
    }
}
