import Foundation

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
