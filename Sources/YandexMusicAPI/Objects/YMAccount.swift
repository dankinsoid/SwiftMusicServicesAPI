import Foundation

public extension YMO {

	struct AccountStatus: Codable {

		public var subeditorLevel: Int?
		public var account: Account
		public var permissions: Permissions?
		public var barBelow: BarBelow?
		public var defaultEmail: String?
		public var plus: Plus?
		public var subeditor: Bool?
		public var subscription: Subscription

		enum CodingKeys: String, CodingKey, CaseIterable {
			case subeditorLevel, account, permissions
			case barBelow = "bar-below"
			case defaultEmail, plus, subeditor, subscription
		}
	}

	struct Account: Codable {

		public var displayName: String?
		public var birthday: String?
		public var secondName: String?
		public var fullName: String?
		public var region: Int?
		public var registeredAt: Date?
		public var serviceAvailable: Bool?
		public var firstName: String?
		public var now: Date?
		public var passportPhones: [PassportPhone]?
		public var hostedUser: Bool?
		public var uid: Int
		public var login: String?

		enum CodingKeys: String, CodingKey, CaseIterable {

			case displayName, birthday, secondName, fullName, region, registeredAt, serviceAvailable, firstName, now
			case passportPhones = "passport-phones"
			case hostedUser, uid, login
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
		public var `default`, values: [String]?
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
	}

	// MARK: - AutoRenewable

	struct AutoRenewable: Codable {

		public var productId: String
		public var expires: Date?
		public var finished: Bool?
		public var vendorHelpUrl: String?
		public var vendor: String?
		public var product: Product
		public var orderId: Int?
	}

	// MARK: - Product

	struct Product: Codable {
		public var features: [String]?
		public var trialDuration: Int?
		public var productId: String
		public var plus: Bool?
		public var feature, trialPeriodDuration, type, commonPeriodDuration: String?
		public var duration: Int?
		public var debug: Bool?
		public var price: Price
	}

	// MARK: - Price

	struct Price: Codable {
		public var amount: Int
		public var currency: String?
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
