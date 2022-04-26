//
// Created by Данил Войдилов on 08.04.2022.
//

import Foundation
import SwiftSoup

public struct VKAudioPlaylistPage {
	public var playlists: [VKPlaylistItemHTML]
}

extension VKAudioPlaylistPage: HTMLStringInitable {
	public init(htmlString html: String) throws {
		let document = try SwiftSoup.parse(html.trimmingCharacters(in: .whitespaces))
		let div = try document.getElementsByClass("Row AudioBlock__content").first()?.children() ?? Elements()
		playlists = try div.map { try VKPlaylistItemHTML(xml: $0) }
	}
}
