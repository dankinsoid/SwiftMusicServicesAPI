import Foundation
import SwiftMusicServicesApi

public extension YMO {

	struct AccountStatus: Codable {

		@NilIfError public var subeditorLevel: Int?
		public var account: Account
		@NilIfError public var permissions: Permissions?
		@NilIfError public var barBelow: BarBelow?
		@NilIfError public var defaultEmail: String?
		@NilIfError public var plus: Plus?
		@NilIfError public var subeditor: Bool?
		@NilIfError public var subscription: Subscription?

		enum CodingKeys: String, CodingKey, CaseIterable {
			case subeditorLevel, account, permissions
			case barBelow = "bar-below"
			case defaultEmail, plus, subeditor, subscription
		}
	}

	struct Account: Codable {

		@NilIfError public var displayName: String?
		@NilIfError public var birthday: String?
		@NilIfError public var secondName: String?
		@NilIfError public var fullName: String?
		@NilIfError public var region: Int?
		@NilIfError public var registeredAt: Date?
		@NilIfError public var serviceAvailable: Bool?
		@NilIfError public var firstName: String?
		@NilIfError public var now: Date?
		@NilIfError public var passportPhones: [PassportPhone]?
		@NilIfError public var hostedUser: Bool?
		@NilIfError public var uid: Int?
		@NilIfError public var login: String?

		enum CodingKeys: String, CodingKey, CaseIterable {

			case displayName, birthday, secondName, fullName, region, registeredAt, serviceAvailable, firstName, now
			case passportPhones = "passport-phones"
			case hostedUser, uid, login
		}
	}
    
    struct Settings: Codable {

        public var uid: Int
			@NilIfError public var lastFmScrobblingEnabled: Bool?
			@NilIfError public var facebookScrobblingEnabled: Bool?
			@NilIfError public var shuffleEnabled: Bool?
			@NilIfError public var addNewTrackOnPlaylistTop: Bool?
			@NilIfError public var volumePercents: Int?
			@NilIfError public var userMusicVisibility: String?
			@NilIfError public var userSocialVisibility: String?
			@NilIfError public var adsDisabled: Bool?
			@NilIfError public var modified: Date?
//      @NilIfError   public var rbtDisabled: String?
			@NilIfError public var theme: String?
			@NilIfError public var promosDisabled: Bool?
			@NilIfError public var autoPlayRadio: Bool?
			@NilIfError public var syncQueueEnabled: Bool?
        
        public init(uid: Int, lastFmScrobblingEnabled: Bool? = nil, facebookScrobblingEnabled: Bool? = nil, shuffleEnabled: Bool? = nil, addNewTrackOnPlaylistTop: Bool? = nil, volumePercents: Int? = nil, userMusicVisibility: String? = nil, userSocialVisibility: String? = nil, adsDisabled: Bool? = nil, modified: Date? = nil, theme: String? = nil, promosDisabled: Bool? = nil, autoPlayRadio: Bool? = nil, syncQueueEnabled: Bool? = nil) {
            self.uid = uid
            self.lastFmScrobblingEnabled = lastFmScrobblingEnabled
            self.facebookScrobblingEnabled = facebookScrobblingEnabled
            self.shuffleEnabled = shuffleEnabled
            self.addNewTrackOnPlaylistTop = addNewTrackOnPlaylistTop
            self.volumePercents = volumePercents
            self.userMusicVisibility = userMusicVisibility
            self.userSocialVisibility = userSocialVisibility
            self.adsDisabled = adsDisabled
            self.modified = modified
            self.theme = theme
            self.promosDisabled = promosDisabled
            self.autoPlayRadio = autoPlayRadio
            self.syncQueueEnabled = syncQueueEnabled
        }
    }


	struct PassportPhone: Codable {
		@NilIfError public var phone: String?
	}

	struct BarBelow: Codable {
		@NilIfError public var bgColor: HEXColor?
		@NilIfError public var textColor: HEXColor?
		@NilIfError public var text: String?
		@NilIfError public var button: Button?
	}

	struct Button: Codable {
		@NilIfError public var bgColor: HEXColor?
		@NilIfError public var textColor: HEXColor?
		@NilIfError public var text: String?
		@NilIfError public var uri: String?
	}

	// MARK: - Permissions

	struct Permissions: Codable {
		@NilIfError public var `default`: [String]?
		@NilIfError public var values: [String]?
		@NilIfError public var until: Date?
	}

	// MARK: - Plus

	struct Plus: Codable {
		public var hasPlus: Bool
		@NilIfError public var isTutorialCompleted: Bool?
	}

	// MARK: - Subscription

	struct Subscription: Codable {

		@NilIfError public var canStartTrial: Bool?
		@NilIfError public var hadAnySubscription: Bool?
		@NilIfError public var nonAutoRenewableRemainder: NonAutoRenewableRemainder?
		@NilIfError public var mcdonalds: Bool?
		@NilIfError public var autoRenewable: [AutoRenewable]?
	}

	// MARK: - AutoRenewable

	struct AutoRenewable: Codable {

		public var productId: String
		@NilIfError public var expires: Date?
		@NilIfError public var finished: Bool?
		@NilIfError public var vendorHelpUrl: String?
		@NilIfError public var vendor: String?
		@NilIfError public var product: Product?
		@NilIfError public var orderId: Int?
	}

	// MARK: - Product

	struct Product: Codable {
		@NilIfError public var features: [String]?
		@NilIfError public var trialDuration: Int?
		public var productId: String
		@NilIfError public var plus: Bool?
		@NilIfError public var feature: String?
		@NilIfError public var trialPeriodDuration: String?
		@NilIfError public var type: String?
		@NilIfError public var commonPeriodDuration: String?
		@NilIfError public var duration: Int?
		@NilIfError public var debug: Bool?
		public var price: Price
	}

	// MARK: - Price

	struct Price: Codable {
		public var amount: Int
		@NilIfError public var currency: String?
	}

	// MARK: - NonAutoRenewableRemainder

	struct NonAutoRenewableRemainder: Codable {
		public var days: Int?
	}

	struct HEXColor: Codable {
		public var red: UInt8
		public var green: UInt8
		public var blue: UInt8
		public var alpha: UInt8

		public init(from decoder: Decoder) throws {
			let container = try decoder.singleValueContainer()
			var hex = try container.decode(String.self)
			if hex.hasPrefix("#") { hex.removeFirst() }
			if hex.count == 6 { hex.append("FF") }
			let scanner = Scanner(string: hex)
			var int: UInt64 = 0
			guard scanner.scanHexInt64(&int) else { throw ScanError.cannotScanColor }
			red = UInt8(int >> 24)
			green = UInt8((int & 0x00FF_0000) >> 16)
			blue = UInt8((int & 0x0000_FF00) >> 8)
			alpha = UInt8(int & 0x0000_00FF)
		}

		public func encode(to encoder: Encoder) throws {
			let int = UInt32(red << 24) | UInt32(green << 16) | UInt32(blue << 8) | UInt32(alpha)
			let str = "#" + String(int, radix: 16, uppercase: true)
			try str.encode(to: encoder)
		}
	}

	private enum ScanError: Error, CaseIterable {
		case cannotScanColor
	}
}
