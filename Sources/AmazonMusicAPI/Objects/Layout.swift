import Foundation
import SwiftMusicServicesApi

public extension Amazon.Objects {

	struct Layout: Codable, Sendable {

		public var methods: [Amazon.Objects.Method]

		public init(methods: [Amazon.Objects.Method]) {
			self.methods = methods
		}
	}

	struct Deeplink: Codable, Sendable {

		public var interface: String
		public var deeplink: String

		public init(interface: String, deeplink: String) {
			self.interface = interface
			self.deeplink = deeplink
		}
	}

	struct Queue: Codable, Sendable, Identifiable {

		public var id: String
		public var interface: String

		public init(id: String, interface: String) {
			self.id = id
			self.interface = interface
		}
	}

	struct Method: Codable, Sendable {

		public var interface: String
		public var queue: Amazon.Objects.Queue?
		public var forced: Bool?
		public var key: String?
		public var value: String?
		public var template: Amazon.Objects.Template?

		public init(interface: String, queue: Amazon.Objects.Queue? = nil, forced: Bool? = nil, key: String? = nil, value: String? = nil, template: Amazon.Objects.Template? = nil) {
			self.interface = interface
			self.queue = queue
			self.forced = forced
			self.key = key
			self.value = value
			self.template = template
		}
	}

	struct Template: Codable, Sendable {

		public var interface: String
		public var widgets: [Amazon.Objects.Widget]?
		public var headerText: Amazon.Objects.Text?

		public init(interface: String, widgets: [Amazon.Objects.Widget]? = nil, headerText: Amazon.Objects.Text? = nil) {
			self.interface = interface
			self.widgets = widgets
			self.headerText = headerText
		}
	}

	struct Text: Codable, Sendable {

		public var text: String

		public init(text: String) {
			self.text = text
		}

		public init(from decoder: any Decoder) throws {
			do {
				let container: KeyedDecodingContainer<Amazon.Objects.Text.CodingKeys> = try decoder.container(keyedBy: Amazon.Objects.Text.CodingKeys.self)
				text = try container.decode(String.self, forKey: Amazon.Objects.Text.CodingKeys.text)
			} catch {
				text = try String(from: decoder)
			}
		}
	}

	struct Widget: Codable, Sendable {

		public var interface: String
		public var uuid: String
		public var header: String?
		public var items: [Item]?

		public struct Item: Codable, Sendable {

			public var id: String?
			public var interface: String
			public var text: Amazon.Objects.Text?
			public var primaryText: Amazon.Objects.Text?
			public var imageAltText: Amazon.Objects.Text?
			public var secondaryText1: Amazon.Objects.Text?
			public var secondaryText1Link: Amazon.Objects.Deeplink?
			public var secondaryText2: Amazon.Objects.Text?
			public var secondaryText2Link: Amazon.Objects.Deeplink?
			public var secondaryText3: Amazon.Objects.Text?
			public var image: URL?
			public var primaryLink: Amazon.Objects.Deeplink?

			public init(id: String? = nil, interface: String, text: Amazon.Objects.Text? = nil, primaryText: Amazon.Objects.Text? = nil, imageAltText: Amazon.Objects.Text? = nil, secondaryText1: Amazon.Objects.Text? = nil, secondaryText1Link: Amazon.Objects.Deeplink? = nil, secondaryText2: Amazon.Objects.Text? = nil, secondaryText2Link: Amazon.Objects.Deeplink? = nil, secondaryText3: Amazon.Objects.Text? = nil, image: URL? = nil, primaryLink: Amazon.Objects.Deeplink? = nil) {
				self.id = id
				self.interface = interface
				self.text = text
				self.primaryText = primaryText
				self.imageAltText = imageAltText
				self.secondaryText1 = secondaryText1
				self.secondaryText1Link = secondaryText1Link
				self.secondaryText2 = secondaryText2
				self.secondaryText2Link = secondaryText2Link
				self.secondaryText3 = secondaryText3
				self.image = image
				self.primaryLink = primaryLink
			}
		}

		public init(interface: String, uuid: String, header: String? = nil, items: [Item]? = nil) {
			self.interface = interface
			self.uuid = uuid
			self.header = header
			self.items = items
		}
	}
}
