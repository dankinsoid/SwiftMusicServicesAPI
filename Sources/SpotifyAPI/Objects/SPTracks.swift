//
//  SPTracks.swift
//  MusicImport
//
//  Created by Daniil on 26.07.2020.
//  Copyright © 2020 Данил Войдилов. All rights reserved.
//

import Foundation

public struct SPTracks: Codable {
    public var href: String
    public var total: Int
    
    public init(href: String, total: Int) {
        self.href = href
        self.total = total
    }
}
