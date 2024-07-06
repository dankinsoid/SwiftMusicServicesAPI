import Foundation

extension Tidal.Objects {
    
    public struct User: Equatable, Codable {
        
        public var userId: Int
        public var email: String?
        public var countryCode: String?
        public var fullName: String?
        public var firstName: String?
        public var lastName: String?
        public var nickname: String?
        public var username: String
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
        
        public init(
            userId: Int,
            email: String? = nil,
            countryCode: String? = nil,
            fullName: String? = nil,
            firstName: String? = nil,
            lastName: String? = nil,
            nickname: String? = nil,
            username: String,
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
            newUser: Bool? = nil
        ) {
            self.userId = userId
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
        }
    }
}
