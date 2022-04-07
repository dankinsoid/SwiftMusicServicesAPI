//
//  Icon.swift
//  YandexAPI
//
//  Created by Daniil on 08.11.2019.
//  Copyright © 2019 Daniil. All rights reserved.
//

import Foundation

extension Yandex.Music.Objects {

    public struct Icon: Codable {
        ///Цвет заднего фона в HEX.
        public var backgroundColor: HEXColor
        ///Ссылка на изображение.
        public var imageUrl: String
        ///клиент Yandex Music
//    public var client: Client
    }

}
