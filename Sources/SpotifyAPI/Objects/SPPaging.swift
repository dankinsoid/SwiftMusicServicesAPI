//
//  SPPaging.swift
//  MusicImport
//
//  Created by Daniil on 22.07.2020.
//  Copyright © 2020 Данил Войдилов. All rights reserved.
//

import Foundation

///The offset-based paging object is a container for a set of objects. It contains a key called items (whose value is an array of the requested objects) along with other keys like previous, next and limit that can be useful in future calls.
public struct SPPaging<Item> {
    ///A link to the Web API endpoint returning the full result of the request.
    public var href: String
    ///The requested data.
    public var items: [Item]
    ///The maximum number of items in the response (as set in the query or by default).
    public var limit: Int
    ///URL to the next page of items.
    public var next: String?
    ///The offset of the items returned (as set in the query or by default).
    public var offset: Int
    ///URL to the previous page of items. ( null if none)
    public var previous: String?
    ///The total number of items available to return.
    public var total: Int
}

extension SPPaging: Decodable where Item: Decodable {}
extension SPPaging: Encodable where Item: Encodable {}
