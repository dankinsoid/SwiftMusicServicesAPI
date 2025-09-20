import Foundation
import SwiftAPIClient

public extension Yandex.Music.Objects {

	struct Icon: Codable {
		/// Цвет заднего фона в HEX.
		public var backgroundColor: HEXColor
		/// Ссылка на изображение.
		public var imageUrl: String
		/// клиент Yandex Music
		//    public var client: Client
	}
}

extension Yandex.Music.Objects.Icon: Mockable {
	public static let mock = Yandex.Music.Objects.Icon(
		backgroundColor: Yandex.Music.Objects.HEXColor(red: 255, green: 0, blue: 0, alpha: 255),
		imageUrl: "https://example.com/icon.png"
	)
}
