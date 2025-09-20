import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public extension YMO {

	struct AccountStatus: Codable {

		public var subeditorLevel: Int?
		public var account: Account
		public var permissions: Permissions?
		public var barBelow: BarBelow?
		public var defaultEmail: String?
		public var plus: Plus?
		public var subeditor: Bool?
		public var subscription: Subscription?

		enum CodingKeys: String, CodingKey, CaseIterable {
			case subeditorLevel, account, permissions
			case barBelow = "bar-below"
			case defaultEmail, plus, subeditor, subscription
		}
		
		public init(subeditorLevel: Int? = nil, account: Account, permissions: Permissions? = nil, barBelow: BarBelow? = nil, defaultEmail: String? = nil, plus: Plus? = nil, subeditor: Bool? = nil, subscription: Subscription? = nil) {
			self.subeditorLevel = subeditorLevel
			self.account = account
			self.permissions = permissions
			self.barBelow = barBelow
			self.defaultEmail = defaultEmail
			self.plus = plus
			self.subeditor = subeditor
			self.subscription = subscription
		}
	}

	struct Account: Codable {

		public var displayName: String?
		public var birthday: String?
		public var secondName: String?
		public var fullName: String?
		public var region: Int?
		public var regionCode: CountryCode?
		public var registeredAt: Date?
		public var serviceAvailable: Bool?
		public var firstName: String?
		public var now: Date?
		public var passportPhones: [PassportPhone]?
		public var hostedUser: Bool?
		public var uid: Int?
		public var login: String?
		public var nonOwnerFamilyMember: Bool?

		enum CodingKeys: String, CodingKey, CaseIterable {

			case displayName, birthday, secondName, fullName, region, registeredAt, serviceAvailable, firstName, now, regionCode, nonOwnerFamilyMember
			case passportPhones = "passport-phones"
			case hostedUser, uid, login
		}
		
		public init(displayName: String? = nil, birthday: String? = nil, secondName: String? = nil, fullName: String? = nil, region: Int? = nil, regionCode: CountryCode? = nil, registeredAt: Date? = nil, serviceAvailable: Bool? = nil, firstName: String? = nil, now: Date? = nil, passportPhones: [PassportPhone]? = nil, hostedUser: Bool? = nil, uid: Int? = nil, login: String? = nil, nonOwnerFamilyMember: Bool? = nil) {
			self.displayName = displayName
			self.birthday = birthday
			self.secondName = secondName
			self.fullName = fullName
			self.region = region
			self.regionCode = regionCode
			self.registeredAt = registeredAt
			self.serviceAvailable = serviceAvailable
			self.firstName = firstName
			self.now = now
			self.passportPhones = passportPhones
			self.hostedUser = hostedUser
			self.uid = uid
			self.login = login
			self.nonOwnerFamilyMember = nonOwnerFamilyMember
		}
	}

	struct Settings: Codable {

		public var uid: Int
		public var lastFmScrobblingEnabled: Bool?
		public var facebookScrobblingEnabled: Bool?
		public var shuffleEnabled: Bool?
		public var addNewTrackOnPlaylistTop: Bool?
		public var volumePercents: Int?
		public var userMusicVisibility: String?
		public var userSocialVisibility: String?
		public var adsDisabled: Bool?
		public var modified: Date?
		//        public var rbtDisabled: String?
		public var theme: String?
		public var promosDisabled: Bool?
		public var autoPlayRadio: Bool?
		public var syncQueueEnabled: Bool?

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
		public var phone: String?
	}

	struct BarBelow: Codable {
		public var bgColor: HEXColor?
		public var textColor: HEXColor?
		public var text: String?
		public var button: Button?
	}

	struct Button: Codable {
		public var bgColor: HEXColor?
		public var textColor: HEXColor?
		public var text: String?
		public var uri: String?
	}

	// MARK: - Permissions

	struct Permissions: Codable {
		public var `default`: [String]?
		public var values: [String]?
		public var until: Date?
	}

	// MARK: - Plus

	struct Plus: Codable {
		public var hasPlus: Bool
		public var isTutorialCompleted: Bool?
	}

	// MARK: - Subscription

	struct Subscription: Codable {

		public var canStartTrial: Bool?
		public var hadAnySubscription: Bool?
		public var nonAutoRenewableRemainder: NonAutoRenewableRemainder?
		public var mcdonalds: Bool?
		public var autoRenewable: [AutoRenewable]?
		
		public init(canStartTrial: Bool? = nil, hadAnySubscription: Bool? = nil, nonAutoRenewableRemainder: NonAutoRenewableRemainder? = nil, mcdonalds: Bool? = nil, autoRenewable: [AutoRenewable]? = nil) {
			self.canStartTrial = canStartTrial
			self.hadAnySubscription = hadAnySubscription
			self.nonAutoRenewableRemainder = nonAutoRenewableRemainder
			self.mcdonalds = mcdonalds
			self.autoRenewable = autoRenewable
		}
	}

	// MARK: - AutoRenewable

	struct AutoRenewable: Codable {

		public var productId: String
		public var expires: Date?
		public var finished: Bool?
		public var vendorHelpUrl: String?
		public var vendor: String?
		public var product: Product?
		public var orderId: Int?
		
		public init(productId: String, expires: Date? = nil, finished: Bool? = nil, vendorHelpUrl: String? = nil, vendor: String? = nil, product: Product? = nil, orderId: Int? = nil) {
			self.productId = productId
			self.expires = expires
			self.finished = finished
			self.vendorHelpUrl = vendorHelpUrl
			self.vendor = vendor
			self.product = product
			self.orderId = orderId
		}
	}

	// MARK: - Product

	struct Product: Codable {
		public var features: [String]?
		public var trialDuration: Int?
		public var productId: String
		public var plus: Bool?
		public var feature: String?
		public var trialPeriodDuration: String?
		public var type: String?
		public var commonPeriodDuration: String?
		public var duration: Int?
		public var debug: Bool?
		public var price: Price
		
		public init(features: [String]? = nil, trialDuration: Int? = nil, productId: String, plus: Bool? = nil, feature: String? = nil, trialPeriodDuration: String? = nil, type: String? = nil, commonPeriodDuration: String? = nil, duration: Int? = nil, debug: Bool? = nil, price: Price) {
			self.features = features
			self.trialDuration = trialDuration
			self.productId = productId
			self.plus = plus
			self.feature = feature
			self.trialPeriodDuration = trialPeriodDuration
			self.type = type
			self.commonPeriodDuration = commonPeriodDuration
			self.duration = duration
			self.debug = debug
			self.price = price
		}
	}

	// MARK: - Price

	struct Price: Codable {
		public var amount: Int
		public var currency: String?
		
		public init(amount: Int, currency: String? = nil) {
			self.amount = amount
			self.currency = currency
		}
	}

	// MARK: - NonAutoRenewableRemainder

	struct NonAutoRenewableRemainder: Codable {
		public var days: Int?
		
		public init(days: Int? = nil) {
			self.days = days
		}
	}

	struct HEXColor: Codable {
		public var red: UInt8
		public var green: UInt8
		public var blue: UInt8
		public var alpha: UInt8

		public init(red: UInt8, green: UInt8, blue: UInt8, alpha: UInt8) {
			self.red = red
			self.green = green
			self.blue = blue
			self.alpha = alpha
		}

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

extension YMO.AccountStatus: Mockable {
	public static let mock = YMO.AccountStatus(
		subeditorLevel: 0,
		account: YMO.Account.mock,
		permissions: YMO.Permissions.mock,
		barBelow: YMO.BarBelow.mock,
		defaultEmail: "mock@example.com",
		plus: YMO.Plus.mock,
		subeditor: false,
		subscription: YMO.Subscription.mock
	)
}

extension YMO.Account: Mockable {
	public static let mock = YMO.Account(
		displayName: "Mock User",
		birthday: "1990-01-01",
		secondName: "User",
		fullName: "Mock User",
		region: 225,
		regionCode: .RU,
		registeredAt: Date(),
		serviceAvailable: true,
		firstName: "Mock",
		now: Date(),
		passportPhones: [YMO.PassportPhone.mock],
		hostedUser: false,
		uid: 123_456_789,
		login: "mockuser",
		nonOwnerFamilyMember: false
	)
}

extension YMO.PassportPhone: Mockable {
	public static let mock = YMO.PassportPhone(
		phone: "+7 900 123-45-67"
	)
}

extension YMO.Permissions: Mockable {
	public static let mock = YMO.Permissions(
		default: ["play", "download"],
		values: ["stream", "hq"],
		until: Date()
	)
}

extension YMO.BarBelow: Mockable {
	public static let mock = YMO.BarBelow(
		bgColor: Yandex.Music.Objects.HEXColor.mock,
		textColor: Yandex.Music.Objects.HEXColor.mock,
		text: "Premium subscription available",
		button: YMO.Button.mock
	)
}

extension YMO.Button: Mockable {
	public static let mock = YMO.Button(
		bgColor: Yandex.Music.Objects.HEXColor.mock,
		textColor: Yandex.Music.Objects.HEXColor.mock,
		text: "Subscribe",
		uri: "https://music.yandex.com/subscription"
	)
}

extension YMO.Plus: Mockable {
	public static let mock = YMO.Plus(
		hasPlus: true,
		isTutorialCompleted: true
	)
}

extension YMO.Subscription: Mockable {
	public static let mock = YMO.Subscription(
		canStartTrial: false,
		hadAnySubscription: true,
		nonAutoRenewableRemainder: YMO.NonAutoRenewableRemainder.mock,
		mcdonalds: false,
		autoRenewable: [YMO.AutoRenewable.mock]
	)
}

extension YMO.AutoRenewable: Mockable {
	public static let mock = YMO.AutoRenewable(
		productId: "com.yandex.music.premium",
		expires: Date(),
		finished: false,
		vendorHelpUrl: "https://support.yandex.com",
		vendor: "yandex",
		product: YMO.Product.mock,
		orderId: 987_654_321
	)
}

extension YMO.Product: Mockable {
	public static let mock = YMO.Product(
		features: ["hq", "download"],
		trialDuration: 30,
		productId: "com.yandex.music.premium",
		plus: true,
		feature: "premium",
		trialPeriodDuration: "P30D",
		type: "subscription",
		commonPeriodDuration: "P1M",
		duration: 30,
		debug: false,
		price: YMO.Price.mock
	)
}

extension YMO.Price: Mockable {
	public static let mock = YMO.Price(
		amount: 299,
		currency: "RUB"
	)
}

extension YMO.NonAutoRenewableRemainder: Mockable {
	public static let mock = YMO.NonAutoRenewableRemainder(
		days: 15
	)
}

extension Yandex.Music.Objects.HEXColor: Mockable {

	public static let mock = Yandex.Music.Objects.HEXColor(red: 255, green: 0, blue: 0, alpha: 255)
}
