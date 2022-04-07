//
//  AccountStatus.swift
//  MusicImport
//
//  Created by crypto_user on 20.12.2019.
//  Copyright © 2019 Данил Войдилов. All rights reserved.
//

import Foundation
import SwiftHttp
import VDCodable

extension Yandex.Music.API {
    
    public func account() async throws -> YMO.AccountStatus {
        try await request(
            url: baseURL.path("account", "status"),
            method: .get
        )
    }
}
