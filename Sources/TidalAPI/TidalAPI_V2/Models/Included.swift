import Foundation
import SwiftAPIClient
@preconcurrency import VDCodable

public extension TDO {

	enum IncludedItem: Codable, Equatable, Sendable {

		case albums(AlbumsResource)
		case artistRoles(ArtistRolesResource)
		case artists(ArtistsResource)
		case artworks(ArtworksResource)
		case playlists(PlaylistsResource)
		case providers(ProvidersResource)
		case searchResults(SearchResultsResource)
		case searchSuggestions(SearchSuggestionsResource)
		case trackFiles(TrackFilesResource)
		case trackManifests(TrackManifestsResource)
		case tracks(TracksResource)
		case userCollections(UserCollectionsResource)
		case userEntitlements(UserEntitlementsResource)
		case userRecommendations(UserRecommendationsResource)
		case userReports(UserReportsResource)
		case users(UsersResource)
		case videos(VideosResource)
		case unknown(JSON)

		public var albums: AlbumsResource? {
			if case let .albums(resource) = self { return resource }
			return nil
		}

		public var artistRoles: ArtistRolesResource? {
			if case let .artistRoles(resource) = self { return resource }
			return nil
		}

		public var artists: ArtistsResource? {
			if case let .artists(resource) = self { return resource }
			return nil
		}

		public var artworks: ArtworksResource? {
			if case let .artworks(resource) = self { return resource }
			return nil
		}

		public var playlists: PlaylistsResource? {
			if case let .playlists(resource) = self { return resource }
			return nil
		}

		public var providers: ProvidersResource? {
			if case let .providers(resource) = self { return resource }
			return nil
		}

		public var searchResults: SearchResultsResource? {
			if case let .searchResults(resource) = self { return resource }
			return nil
		}

		public var searchSuggestions: SearchSuggestionsResource? {
			if case let .searchSuggestions(resource) = self { return resource }
			return nil
		}

		public var trackFiles: TrackFilesResource? {
			if case let .trackFiles(resource) = self { return resource }
			return nil
		}

		public var trackManifests: TrackManifestsResource? {
			if case let .trackManifests(resource) = self { return resource }
			return nil
		}

		public var tracks: TracksResource? {
			if case let .tracks(resource) = self { return resource }
			return nil
		}

		public var userCollections: UserCollectionsResource? {
			if case let .userCollections(resource) = self { return resource }
			return nil
		}

		public var userEntitlements: UserEntitlementsResource? {
			if case let .userEntitlements(resource) = self { return resource }
			return nil
		}

		public var userRecommendations: UserRecommendationsResource? {
			if case let .userRecommendations(resource) = self { return resource }
			return nil
		}

		public var userReports: UserReportsResource? {
			if case let .userReports(resource) = self { return resource }
			return nil
		}

		public var users: UsersResource? {
			if case let .users(resource) = self { return resource }
			return nil
		}

		public var videos: VideosResource? {
			if case let .videos(resource) = self { return resource }
			return nil
		}

		public init(from decoder: Decoder) throws {
			let container = try decoder.container(keyedBy: CodingKeys.self)
			let type = try container.decode(String.self, forKey: .type)

			switch type {
			case "albums":
				self = try .albums(AlbumsResource(from: decoder))
			case "artistRoles":
				self = try .artistRoles(ArtistRolesResource(from: decoder))
			case "artists":
				self = try .artists(ArtistsResource(from: decoder))
			case "artworks":
				self = try .artworks(ArtworksResource(from: decoder))
			case "playlists":
				self = try .playlists(PlaylistsResource(from: decoder))
			case "providers":
				self = try .providers(ProvidersResource(from: decoder))
			case "searchResults":
				self = try .searchResults(SearchResultsResource(from: decoder))
			case "searchSuggestions":
				self = try .searchSuggestions(SearchSuggestionsResource(from: decoder))
			case "trackFiles":
				self = try .trackFiles(TrackFilesResource(from: decoder))
			case "trackManifests":
				self = try .trackManifests(TrackManifestsResource(from: decoder))
			case "tracks":
				self = try .tracks(TracksResource(from: decoder))
			case "userCollections":
				self = try .userCollections(UserCollectionsResource(from: decoder))
			case "userEntitlements":
				self = try .userEntitlements(UserEntitlementsResource(from: decoder))
			case "userRecommendations":
				self = try .userRecommendations(UserRecommendationsResource(from: decoder))
			case "userReports":
				self = try .userReports(UserReportsResource(from: decoder))
			case "users":
				self = try .users(UsersResource(from: decoder))
			case "videos":
				self = try .videos(VideosResource(from: decoder))
			default:
				self = try .unknown(JSON(from: decoder))
			}
		}

		public func encode(to encoder: Encoder) throws {
			switch self {
			case let .albums(resource):
				try resource.encode(to: encoder)
			case let .artistRoles(resource):
				try resource.encode(to: encoder)
			case let .artists(resource):
				try resource.encode(to: encoder)
			case let .artworks(resource):
				try resource.encode(to: encoder)
			case let .playlists(resource):
				try resource.encode(to: encoder)
			case let .providers(resource):
				try resource.encode(to: encoder)
			case let .searchResults(resource):
				try resource.encode(to: encoder)
			case let .searchSuggestions(resource):
				try resource.encode(to: encoder)
			case let .trackFiles(resource):
				try resource.encode(to: encoder)
			case let .trackManifests(resource):
				try resource.encode(to: encoder)
			case let .tracks(resource):
				try resource.encode(to: encoder)
			case let .userCollections(resource):
				try resource.encode(to: encoder)
			case let .userEntitlements(resource):
				try resource.encode(to: encoder)
			case let .userRecommendations(resource):
				try resource.encode(to: encoder)
			case let .userReports(resource):
				try resource.encode(to: encoder)
			case let .users(resource):
				try resource.encode(to: encoder)
			case let .videos(resource):
				try resource.encode(to: encoder)
			case let .unknown(json):
				try json.encode(to: encoder)
			}
		}

		private enum CodingKeys: String, CodingKey {
			case type
		}
	}

	enum IncludeType: String, Codable, CaseIterable, Sendable, Equatable {

		case albums
		case artistRoles
		case artists
		case artworks
		case playlists
		case providers
		case searchResults
		case searchSuggestions
		case trackFiles
		case trackManifests
		case tracks
		case userCollections
		case userEntitlements
		case userRecommendations
		case userReports
		case users
		case videos
	}

	typealias Included = [IncludedItem]
}

extension TDO.IncludedItem: Mockable {
	
	public static let mock = TDO.IncludedItem.searchResults(.mock)
}
