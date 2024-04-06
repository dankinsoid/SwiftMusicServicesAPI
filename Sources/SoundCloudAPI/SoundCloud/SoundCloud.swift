// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension SoundCloud.API {

	struct Server: Hashable {

		/// URL of the server
		public var url: URL

		public init(_ url: URL) {
			self.url = url
		}

		public static var `default` = SoundCloud.API.Server.main

		public static let main = SoundCloud.API.Server(URL(string: "https://api.soundcloud.com")!)
	}
}

public extension APIClient.Configs {

	/// SoundCloud server
	var soundCloudServer: SoundCloud.API.Server {
		get { self[\.soundCloudServer] ?? .default }
		set { self[\.soundCloudServer] = newValue }
	}
}

public extension SoundCloud.API {
	var likes: Likes { Likes(client: client) }
	struct Likes { var client: APIClient }
}

public extension SoundCloud.API {
	var me: Me { Me(client: client) }
	struct Me { var client: APIClient }
}

public extension SoundCloud.API {
	var miscellaneous: Miscellaneous { Miscellaneous(client: client) }
	struct Miscellaneous { var client: APIClient }
}

public extension SoundCloud.API {
	var oauth: Oauth { Oauth(client: client) }
	struct Oauth { var client: APIClient }
}

public extension SoundCloud.API {
	var playlists: Playlists { Playlists(client: client) }
	struct Playlists { var client: APIClient }
}

public extension SoundCloud.API {
	var reposts: Reposts { Reposts(client: client) }
	struct Reposts { var client: APIClient }
}

public extension SoundCloud.API {
	var search: Search { Search(client: client) }
	struct Search { var client: APIClient }
}

public extension SoundCloud.API {
	var tracks: Tracks { Tracks(client: client) }
	struct Tracks { var client: APIClient }
}

public extension SoundCloud.API {
	var users: Users { Users(client: client) }
	struct Users { var client: APIClient }
}
