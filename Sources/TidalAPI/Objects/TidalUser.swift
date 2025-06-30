import Foundation

public extension Tidal.Objects {

    struct User: Equatable, Codable, Identifiable, Sendable {

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
            id = try container.decodeIfPresent(Int.self, forKey: .id) ?? container.decode(Int.self, forKey: .userId)
            email = try? container.decodeIfPresent(String.self, forKey: .email)
            countryCode = try? container.decodeIfPresent(String.self, forKey: .countryCode)
            fullName = try? container.decodeIfPresent(String.self, forKey: .fullName)
            firstName = try? container.decodeIfPresent(String.self, forKey: .firstName)
            lastName = try? container.decodeIfPresent(String.self, forKey: .lastName)
            nickname = try? container.decodeIfPresent(String.self, forKey: .nickname)
            username = try? container.decodeIfPresent(String.self, forKey: .username)
            address = try? container.decodeIfPresent(String.self, forKey: .address)
            city = try? container.decodeIfPresent(String.self, forKey: .city)
            postalcode = try? container.decodeIfPresent(String.self, forKey: .postalcode)
            usState = try? container.decodeIfPresent(String.self, forKey: .usState)
            phoneNumber = try? container.decodeIfPresent(String.self, forKey: .phoneNumber)
            birthday = try? container.decodeIfPresent(String.self, forKey: .birthday)
            gender = try? container.decodeIfPresent(String.self, forKey: .gender)
            imageId = try? container.decodeIfPresent(String.self, forKey: .imageId)
            channelId = try? container.decodeIfPresent(Int.self, forKey: .channelId)
            parentId = try? container.decodeIfPresent(Int.self, forKey: .parentId)
            acceptedEULA = try? container.decodeIfPresent(Bool.self, forKey: .acceptedEULA)
            created = try? container.decodeIfPresent(Date.self, forKey: .created)
            updated = try? container.decodeIfPresent(Date.self, forKey: .updated)
            facebookUid = try? container.decodeIfPresent(Int.self, forKey: .facebookUid)
            appleUid = try? container.decodeIfPresent(String.self, forKey: .appleUid)
            newUser = try? container.decodeIfPresent(Bool.self, forKey: .newUser)
            picture = try? container.decodeIfPresent(String.self, forKey: .picture)
            newsletter = try? container.decodeIfPresent(Bool.self, forKey: .newsletter)
            dateOfBirth = try? container.decodeIfPresent(Date.self, forKey: .dateOfBirth)
            userId = try? container.decodeIfPresent(Int.self, forKey: .userId)
        }
    }
}
