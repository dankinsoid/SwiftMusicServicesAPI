//
//  SPCursor.swift
//  MusicImport
//
//  Created by Daniil on 23.07.2020.
//  Copyright © 2020 Данил Войдилов. All rights reserved.
//

import Foundation

public struct SPCursor: Codable {
    ///The cursor to use as key to find the next page of items.
    public var after: String
}
