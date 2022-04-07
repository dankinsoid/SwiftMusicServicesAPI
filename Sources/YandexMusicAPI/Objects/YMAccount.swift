//
//  YMAccount.swift
//  MusicImport
//
//  Created by crypto_user on 20.12.2019.
//  Copyright © 2019 Данил Войдилов. All rights reserved.
//

import Foundation

extension YMO {
    
    public struct AccountStatus: Codable {
        public let subeditorLevel: Int?
        public let account: Account
        public let permissions: Permissions?
        public let barBelow: BarBelow?
        public let defaultEmail: String?
        public let plus: Plus?
        public let subeditor: Bool?
        public let subscription: Subscription
        
        enum CodingKeys: String, CodingKey {
            case subeditorLevel, account, permissions
            case barBelow = "bar-below"
            case defaultEmail, plus, subeditor, subscription
        }
    }
    
    public struct Account: Codable {
        public let displayName: String
        public let birthday: String?
        public let secondName: String?
        public let fullName: String?
        public let region: Int?
        public let registeredAt: Date?
        public let serviceAvailable: Bool?
        public let firstName: String?
        public let now: Date?
        public let passportPhones: [PassportPhone]?
        public let hostedUser: Bool?
        public let uid: Int
        public let login: String?
        
        enum CodingKeys: String, CodingKey {
            case displayName, birthday, secondName, fullName, region, registeredAt, serviceAvailable, firstName, now
            case passportPhones = "passport-phones"
            case hostedUser, uid, login
        }
    }
    
    public struct PassportPhone: Codable {
        public let phone: String?
    }
    
    public struct BarBelow: Codable {
        public let bgColor: HEXColor?
        public let textColor: HEXColor?
        public let text: String?
        public let button: Button?
    }
    
    public struct Button: Codable {
        public let bgColor: HEXColor?
        public let textColor: HEXColor?
        public let text: String?
        public let uri: String?
    }
    
    // MARK: - Permissions
    public struct Permissions: Codable {
        public let `default`, values: [String]?
        public let until: Date?

    }
    
    // MARK: - Plus
    public struct Plus: Codable {
        public let hasPlus: Bool
        public let isTutorialCompleted: Bool?
    }
    
    // MARK: - Subscription
    public struct Subscription: Codable {
        public let canStartTrial: Bool
        public let nonAutoRenewableRemainder: NonAutoRenewableRemainder?
        public let mcdonalds: Bool?
        public let autoRenewable: [AutoRenewable]?
    }
    
    // MARK: - AutoRenewable
    public struct AutoRenewable: Codable {
        public let productId: String
        public let expires: Date?
        public let finished: Bool?
        public let vendorHelpUrl: String?
        public let vendor: String?
        public let product: Product
        public let orderId: Int?
    }
    
    // MARK: - Product
    public struct Product: Codable {
        public let features: [String]?
        public let trialDuration: Int?
        public let productId: String
        public let plus: Bool?
        public let feature, trialPeriodDuration, type, commonPeriodDuration: String?
        public let duration: Int?
        public let debug: Bool?
        public let price: Price
    }
    
    // MARK: - Price
    public struct Price: Codable {
        public let amount: Int
        public let currency: String?
    }
    
    // MARK: - NonAutoRenewableRemainder
    public struct NonAutoRenewableRemainder: Codable {
        public let days: Int?
    }
    
    public struct HEXColor: Codable {
        
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
            var int: UInt32 = 0
            guard scanner.scanHexInt32(&int) else { throw ScanError.cannotScanColor }
            red = UInt8(int >> 24)
            green = UInt8((int & 0x00FF0000) >> 16)
            blue = UInt8((int & 0x0000FF00) >> 8)
            alpha = UInt8(int & 0x000000FF)
        }
        
        public func encode(to encoder: Encoder) throws {
            let int = UInt32(red << 24) | UInt32(green << 16) | UInt32(blue << 8) | UInt32(alpha)
            let str = "#" + String(int, radix: 16, uppercase: true)
            try str.encode(to: encoder)
        }
    }

    private enum ScanError: Error {
        case cannotScanColor
    }
}

