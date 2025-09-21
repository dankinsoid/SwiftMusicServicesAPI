import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public extension YouTube.API {

	var channels: Channels {
		Channels(client: client("channels"))
	}

	struct Channels {
		let client: APIClient
	}
}

public extension YouTube.API.Channels {

	/// Returns a collection of zero or more channel resources that match the request criteria.
	/// - Parameters:
	///   - filter: Filter
	///   - hl: The hl parameter instructs the API to retrieve localized resource metadata for a specific application language that the YouTube website supports.
	///   The parameter value must be a language code included in the list returned by the i18nLanguages.list method.
	///   If localized resource details are available in that language, the resource's snippet.localized object will contain the localized values.
	///   However, if localized details are not available, the snippet.localized object will contain resource details in the resource's default language.
	///   - part: The part parameter specifies a comma-separated list of one or more channel resource properties that the API response will include.
	///   - limit: The maximum number of items that should be returned in the result set. The default value is nil.
	///   - pageToken: The pageToken parameter identifies a specific page in the result set that should be returned. In an API response, the nextPageToken and prevPageToken properties identify other pages that could be retrieved.
	func list(
		filter: Filter,
		hl: String? = nil,
		part: [YTO.Channel.CodingKeys],
		limit: Int? = nil,
		pageToken: String? = nil
	) -> YTPaging<YTO.Channel> {
		let filterParams = filter.params
		let onBehalfOfContentOwner = filter.onBehalfOfContentOwner
		return YTPaging(
			client: client.query([
				"part": part,
				filterParams.0: filterParams.1,
				"onBehalfOfContentOwner": onBehalfOfContentOwner,
				"hl": hl,
			])
			.auth(enabled: filter.isMyRating || onBehalfOfContentOwner != nil),
			limit: limit,
			pageToken: pageToken
		)
	}

	enum Filter: Codable, Equatable {

		/// The parameter specifies a YouTube username, thereby requesting the channel associated with that username.
		case username(String)
		/// The id parameter specifies a list of the YouTube channel ID(s) for the resource(s) that are being retrieved. In a channel resource, the id property specifies the channel's YouTube channel ID.
		case id([String])
		/// Set this parameter to instruct the API to only return channels owned by the authenticated user.
		case mine
		/// The parameter specifies a YouTube handle, thereby requesting the channel associated with that handle. The parameter value can be prepended with an @ symbol. For example, to retrieve the resource for the "Google for Developers" channel, set the forHandle parameter value to either GoogleDevelopers or @GoogleDevelopers.
		case handle(String)
		/// Set this parameter's value to instruct the API to only return channels managed by the content owner. The parameter indicates that the request's authorization credentials identify a YouTube CMS user who is acting on behalf of the content owner specified in the parameter value.
		/// This parameter is intended for YouTube content partners that own and manage many different YouTube channels. It allows content owners to authenticate once and get access to all their video and channel data, without having to provide authentication credentials for each individual channel.
		/// The CMS account that the user authenticates with must be linked to the specified YouTube content owner.
		case contentOwner(String)
		/// This parameter has been deprecated. The parameter specified a YouTube guide category and could be used to request YouTube channels associated with that category.
		@available(*, deprecated)
		case categoryId(String)

		public var params: (String, Encodable) {
			switch self {
			case let .username(name): return ("forUsername", name)
			case let .id(id): return ("id", id)
			case .mine: return ("mine", true)
			case let .handle(handle): return ("forHandle", handle)
			case .contentOwner: return ("managedByMe", true)
			case let .categoryId(id): return ("categoryId", id)
			}
		}

		public var onBehalfOfContentOwner: String? {
			if case let .contentOwner(contentOwner) = self { return contentOwner }
			return nil
		}

		var isMyRating: Bool {
			if case .mine = self { true } else { false }
		}
	}
}
