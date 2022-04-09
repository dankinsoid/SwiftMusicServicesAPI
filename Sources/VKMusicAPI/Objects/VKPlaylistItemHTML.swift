//
// Created by Данил Войдилов on 08.04.2022.
//

import Foundation
import SwiftSoup

public struct VKPlaylistItemHTML: XMLInitable {
	public var href: String
	public var act: String? {
		href.components(separatedBy: "act=").dropFirst().first?.components(separatedBy: "&").first
	}
	public var image: String?
	public var title: String
	public var subtitle: String
	public var id: Int? {
		Int(href.components(separatedBy: "audio_playlist").dropFirst().first?.prefix(while: { $0.isNumber }) ?? "")
	}

	public init(xml: SwiftSoup.Element) throws {
		let div = xml.child(0)
		href = try div.select("a").attr("href")
		title = try xml.getElementsByClass("audioPlaylistsPage__title ").text()
		subtitle = try xml.getElementsByClass("audioPlaylistsPage__author").text()
		do {
			let style = try xml.getElementsByClass("audioPlaylistsPage__cover").first()?.attr("style")
			image = style?.components(separatedBy: "url('").dropFirst().first?.components(separatedBy: "');").first
		} catch {
			image = nil
		}
	}

	public init(href: String, image: String? = nil, title: String, subtitle: String) {
		self.href = href
		self.image = image
		self.title = title
		self.subtitle = subtitle
	}
}