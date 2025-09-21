import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public extension YouTube.API {

	var playlistItems: PlaylistItems {
		PlaylistItems(client: client("playlistItems"))
	}

	struct PlaylistItems {
		let client: APIClient
	}
}

public extension YouTube.API.PlaylistItems {

	/// Returns a collection of playlist items that match the API request parameters.
	/// You can retrieve all of the playlist items in a specified playlist or retrieve one or more playlist items by their unique IDs.
	///
	/// - Parameters:
	///   - filter: Filter.
	///   - videoId: The videoId parameter specifies that the request should return only the playlist items that contain the specified video.
	///   If the parameter identifies a property that contains child properties, the child properties will be included in the response.
	///   For example, in a playlistItem resource, the snippet property contains numerous fields, including the title, description, position, and resourceId properties. As such, if you set part=snippet, the API response will contain all of those properties.
	///   - onBehalfOfContentOwner: This parameter can only be used in a properly authorized request. Note: This parameter is intended exclusively for YouTube content partners.
	///   The onBehalfOfContentOwner parameter indicates that the request's authorization credentials identify a YouTube CMS user who is acting on behalf of the content owner specified in the parameter value.
	///   This parameter is intended for YouTube content partners that own and manage many different YouTube channels. It allows content owners to authenticate once and get access to all their video and channel data, without having to provide authentication credentials for each individual channel.
	///   The CMS account that the user authenticates with must be linked to the specified YouTube content owner.
	///   - part: The part parameter specifies a list of one or more playlistItem resource properties that the API response will include.
	///   - limit: Limit of number of returned items.
	///   - pageToken: The pageToken parameter identifies a specific page in the result set that should be returned. In an API response, the nextPageToken and prevPageToken properties identify other pages that could be retrieved.
	func list(
		filter: Filter,
		videoId: String? = nil,
		part: [YTO.PlaylistItem.CodingKeys],
		onBehalfOfContentOwner: String? = nil,
		limit: Int? = nil,
		pageToken: String? = nil
	) -> YTPaging<YTO.PlaylistItem> {
		YTPaging(
			client: client.query([
				"videoId": videoId,
				filter.params.0: filter.params.1,
				"onBehalfOfContentOwner": onBehalfOfContentOwner,
				"part": part,
			]),
			limit: limit,
			pageToken: pageToken
		)
	}

	enum Filter: Codable, Equatable {

		/// The playlistId parameter specifies the unique ID of the playlist for which you want to retrieve playlist items. Note that even though this is an optional parameter, every request to retrieve playlist items must specify a value for either the id parameter or the playlistId parameter.
		case playlist(String)
		/// The id parameter specifies a comma-separated list of one or more unique playlist item IDs.
		case id([String])

		public var params: (String, Encodable) {
			switch self {
			case let .playlist(id): return ("playlistId", id)
			case let .id(id): return ("id", id)
			}
		}
	}
}

public extension YouTube.API.PlaylistItems {

	/// Adds a resource to a playlist.
	///
	///  Requires one of scopes:
	///  - https://www.googleapis.com/auth/youtubepartner
	///  - https://www.googleapis.com/auth/youtube
	///  - https://www.googleapis.com/auth/youtube.force-ssl
	///
	/// - Parameters:
	///   - playlistId: ID of the playlist. `snippet.playlistId.`
	///   - resourceId: Resource ID. `snippet.resourceId`
	///   - position: Position of the resource.. `snippet.position`
	///   - startAt:`contentDetails.startAt`
	///   - endAt:`contentDetails.endAt`
	///   - note:`contentDetails.note`
	///   - onBehalfOfContentOwner: This parameter can only be used in a properly authorized request. Note: This parameter is intended exclusively for YouTube content partners.
	///   The onBehalfOfContentOwner parameter indicates that the request's authorization credentials identify a YouTube CMS user who is acting on behalf of the content owner specified in the parameter value.
	///   This parameter is intended for YouTube content partners that own and manage many different YouTube channels. It allows content owners to authenticate once and get access to all their video and channel data, without having to provide authentication credentials for each individual channel.
	///   The CMS account that the user authenticates with must be linked to the specified YouTube content owner.
	@discardableResult
	func insert(
		playlistId: String,
		resourceId: YTO.PlaylistItem.Snippet.ResourceId,
		position: UInt? = nil,
		startAt: String? = nil,
		endAt: String? = nil,
		note: String? = nil,
		onBehalfOfContentOwner: String? = nil
	) async throws -> YTO.PlaylistItem {
		try await client
			.query([
				"part": ["snippet", "contentDetails"],
				"onBehalfOfContentOwner": onBehalfOfContentOwner,
			])
			.body(
				YTO.PlaylistItem(
					snippet: YTO.PlaylistItem.Snippet(
						playlistId: playlistId,
						position: position,
						resourceId: resourceId
					),
					contentDetails: YouTube.Objects.PlaylistItem.ContentDetails(
						startAt: startAt,
						endAt: endAt,
						note: note
					)
				)
			)
			.post()
	}

	/// Adds a resource to a playlist.
	///
	///  Requires one of scopes:
	///  - https://www.googleapis.com/auth/youtubepartner
	///  - https://www.googleapis.com/auth/youtube
	///  - https://www.googleapis.com/auth/youtube.force-ssl
	///
	/// - Parameters:
	///   - item: Playlist item.
	///   - onBehalfOfContentOwner: This parameter can only be used in a properly authorized request. Note: This parameter is intended exclusively for YouTube content partners.
	///   The onBehalfOfContentOwner parameter indicates that the request's authorization credentials identify a YouTube CMS user who is acting on behalf of the content owner specified in the parameter value.
	///   This parameter is intended for YouTube content partners that own and manage many different YouTube channels. It allows content owners to authenticate once and get access to all their video and channel data, without having to provide authentication credentials for each individual channel.
	///   The CMS account that the user authenticates with must be linked to the specified YouTube content owner.
	@discardableResult
	func insert(
		_ item: YTO.PlaylistItem,
		onBehalfOfContentOwner: String? = nil
	) async throws -> YTO.PlaylistItem {
		try await insert(
			playlistId: item.snippet.unwrap(throwing: AnyError("snippet.playlistId must be specified")).playlistId,
			resourceId: item.snippet.unwrap(throwing: AnyError("snippet.resourceId must be specified")).resourceId,
			position: item.snippet?.position,
			startAt: item.contentDetails?.startAt,
			endAt: item.contentDetails?.endAt,
			note: item.contentDetails?.note,
			onBehalfOfContentOwner: onBehalfOfContentOwner
		)
	}
}

public extension YouTube.API.PlaylistItems {

	/// Modifies a playlist item. For example, you could update the item's position in the playlist.
	///
	///  Requires one of scopes:
	///  - https://www.googleapis.com/auth/youtubepartner
	///  - https://www.googleapis.com/auth/youtube
	///  - https://www.googleapis.com/auth/youtube.force-ssl
	///
	/// - Parameters:
	///   - item: Updated playlist item.
	///   - onBehalfOfContentOwner: This parameter can only be used in a properly authorized request. Note: This parameter is intended exclusively for YouTube content partners.
	///   The onBehalfOfContentOwner parameter indicates that the request's authorization credentials identify a YouTube CMS user who is acting on behalf of the content owner specified in the parameter value.
	///   This parameter is intended for YouTube content partners that own and manage many different YouTube channels. It allows content owners to authenticate once and get access to all their video and channel data, without having to provide authentication credentials for each individual channel.
	///   The CMS account that the user authenticates with must be linked to the specified YouTube content owner.
	///   - part: The part parameter specifies a comma-separated list of one or more playlist resource properties that the API response will include.
	@discardableResult
	func update(
		_ item: YTO.PlaylistItem,
		onBehalfOfContentOwner: String? = nil,
		part: [YTO.PlaylistItem.CodingKeys]
	) async throws -> YTO.PlaylistItem {
		try await update(
			id: item.id.unwrap(throwing: AnyError("id must be specified")),
			playlistId: item.snippet.unwrap(throwing: AnyError("snippet.playlistId must be specified")).playlistId,
			resourceId: item.snippet.unwrap(throwing: AnyError("snippet.resourceId must be specified")).resourceId,
			position: item.snippet?.position,
			startAt: item.contentDetails?.startAt,
			endAt: item.contentDetails?.endAt,
			note: item.contentDetails?.note,
			onBehalfOfContentOwner: onBehalfOfContentOwner,
			part: part
		)
	}

	/// Modifies a playlist item. For example, you could update the item's position in the playlist.
	///
	///  Requires one of scopes:
	///  - https://www.googleapis.com/auth/youtubepartner
	///  - https://www.googleapis.com/auth/youtube
	///  - https://www.googleapis.com/auth/youtube.force-ssl
	///
	/// - Parameters:
	///   - id: Identifietr of the playlist item.
	///   - playlistId: ID of the playlist. `snippet.playlistId.`
	///   - resourceId: Resource ID. `snippet.resourceId`
	///   - position: Position of the resource.. `snippet.position`
	///   - startAt:`contentDetails.startAt`
	///   - endAt:`contentDetails.endAt`
	///   - note:`contentDetails.note`
	///   - onBehalfOfContentOwner: This parameter can only be used in a properly authorized request. Note: This parameter is intended exclusively for YouTube content partners.
	///   The onBehalfOfContentOwner parameter indicates that the request's authorization credentials identify a YouTube CMS user who is acting on behalf of the content owner specified in the parameter value.
	///   This parameter is intended for YouTube content partners that own and manage many different YouTube channels. It allows content owners to authenticate once and get access to all their video and channel data, without having to provide authentication credentials for each individual channel.
	///   The CMS account that the user authenticates with must be linked to the specified YouTube content owner.
	///   - part: The part parameter specifies a comma-separated list of one or more playlist resource properties that the API response will include.
	@discardableResult
	func update(
		id: String,
		playlistId: String,
		resourceId: YTO.PlaylistItem.Snippet.ResourceId,
		position: UInt? = nil,
		startAt: String? = nil,
		endAt: String? = nil,
		note: String? = nil,
		onBehalfOfContentOwner: String? = nil,
		part: [YTO.PlaylistItem.CodingKeys]
	) async throws -> YTO.PlaylistItem {
		try await client
			.query([
				"part": part,
				"onBehalfOfContentOwner": onBehalfOfContentOwner,
			])
			.body(
				YTO.PlaylistItem(
					id: id,
					snippet: YTO.PlaylistItem.Snippet(
						playlistId: playlistId,
						position: position,
						resourceId: resourceId
					),
					contentDetails: YouTube.Objects.PlaylistItem.ContentDetails(
						startAt: startAt,
						endAt: endAt,
						note: note
					)
				)
			)
			.put()
	}
}

public extension YouTube.API.PlaylistItems {

	/// Deletes a playlist item.
	///
	///  Requires one of scopes:
	///  - https://www.googleapis.com/auth/youtubepartner
	///  - https://www.googleapis.com/auth/youtube
	///  - https://www.googleapis.com/auth/youtube.force-ssl
	///
	/// - Parameters:
	///   - id: Identifier of the playlist item.
	///   - onBehalfOfContentOwner: This parameter can only be used in a properly authorized request. Note: This parameter is intended exclusively for YouTube content partners.
	///   The onBehalfOfContentOwner parameter indicates that the request's authorization credentials identify a YouTube CMS user who is acting on behalf of the content owner specified in the parameter value.
	///   This parameter is intended for YouTube content partners that own and manage many different YouTube channels. It allows content owners to authenticate once and get access to all their video and channel data, without having to provide authentication credentials for each individual channel.
	///   The CMS account that the user authenticates with must be linked to the specified YouTube content owner.
	func delete(
		id: String,
		onBehalfOfContentOwner: String? = nil
	) async throws {
		try await client
			.query([
				"id": id,
				"onBehalfOfContentOwner": onBehalfOfContentOwner,
			])
			.delete()
	}
}

public extension YouTube.Objects {

	struct PlaylistItem: Codable, Equatable {

		public var id: String?
		public var snippet: Snippet?
		public var contentDetails: ContentDetails?
		public var status: YTO.PrivacyStatus?

		public enum CodingKeys: String, CodingKey, Codable, Hashable {
			case id
			case snippet
			case contentDetails
			case status
		}

		public init(id: String? = nil, snippet: Snippet? = nil, contentDetails: ContentDetails? = nil, status: YTO.PrivacyStatus? = nil) {
			self.id = id
			self.snippet = snippet
			self.contentDetails = contentDetails
			self.status = status
		}

		public struct Snippet: Codable, Equatable {

			public var publishedAt: Date?
			public var channelId: String?
			public var title: String?
			public var description: String?
			public var thumbnails: YTO.Thumbnails?
			public var channelTitle: String?
			public var videoOwnerChannelTitle: String?
			public var videoOwnerChannelId: String?
			public var playlistId: String
			public var position: UInt?
			public var resourceId: ResourceId

			public init(publishedAt: Date? = nil, channelId: String? = nil, title: String? = nil, description: String? = nil, thumbnails: YTO.Thumbnails? = nil, channelTitle: String? = nil, videoOwnerChannelTitle: String? = nil, videoOwnerChannelId: String? = nil, playlistId: String, position: UInt? = nil, resourceId: ResourceId) {
				self.publishedAt = publishedAt
				self.channelId = channelId
				self.title = title
				self.description = description
				self.thumbnails = thumbnails
				self.channelTitle = channelTitle
				self.videoOwnerChannelTitle = videoOwnerChannelTitle
				self.videoOwnerChannelId = videoOwnerChannelId
				self.playlistId = playlistId
				self.position = position
				self.resourceId = resourceId
			}

			public struct ResourceId: Codable, Equatable {

				public var kind: String?
				public var videoId: String?
				public var channelId: String?
				public var playlistId: String?

				public init(kind: String? = nil, videoId: String? = nil, channelId: String? = nil, playlistId: String? = nil) {
					self.kind = kind
					self.videoId = videoId
				}
			}
		}

		public struct ContentDetails: Codable, Equatable {
			public var videoId: String?
			public var startAt: String?
			public var endAt: String?
			public var note: String?
			public var videoPublishedAt: Date?

			public init(videoId: String? = nil, startAt: String? = nil, endAt: String? = nil, note: String? = nil, videoPublishedAt: Date? = nil) {
				self.videoId = videoId
				self.startAt = startAt
				self.endAt = endAt
				self.note = note
				self.videoPublishedAt = videoPublishedAt
			}
		}
	}
}
