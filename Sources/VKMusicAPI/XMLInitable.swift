//
//  VKRequests.swift
//  MusicImport
//
//  Created by Данил Войдилов on 03.07.2019.
//  Copyright © 2019 Данил Войдилов. All rights reserved.
//

import SwiftSoup

public protocol XMLInitable {
	init(xml: SwiftSoup.Element) throws
}