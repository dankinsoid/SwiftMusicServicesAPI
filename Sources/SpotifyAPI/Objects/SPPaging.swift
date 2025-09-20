import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

/// The offset-based paging object is a container for a set of objects. It contains a key called items (whose value is an array of the requested objects) along with other keys like previous, next and limit that can be useful in future calls.
public struct SPPaging<Item> {
	/// A link to the Web API endpoint returning the full result of the request.
	public var href: String
	/// The requested data.
	@SafeDecodeArray public var items: [Item]
	/// The maximum number of items in the response (as set in the query or by default).
	public var limit: Int
	/// URL to the next page of items.
	public var next: String?
	/// The offset of the items returned (as set in the query or by default).
	public var offset: Int
	/// URL to the previous page of items. ( null if none)
	public var previous: String?
	/// The total number of items available to return.
	public var total: Int

	public init(href: String, items: [Item], limit: Int, next: String? = nil, offset: Int, previous: String? = nil, total: Int) {
		self.href = href
		_items = SafeDecodeArray(items)
		self.limit = limit
		self.next = next
		self.offset = offset
		self.previous = previous
		self.total = total
	}
}

extension SPPaging: Decodable where Item: Decodable {}
extension SPPaging: Encodable where Item: Encodable {}
extension SPPaging: Sendable where Item: Sendable {}

extension SPPaging: Mockable where Item: Mockable {
	public static var mock: SPPaging<Item> {
		SPPaging(
			href: "https://api.spotify.com/v1/me/tracks?offset=0&limit=20",
			items: [Item.mock],
			limit: 20,
			offset: 0,
			total: 1
		)
	}
}
