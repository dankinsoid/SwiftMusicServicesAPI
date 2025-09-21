import Foundation
import SwiftAPIClient

public extension TDO {

	// MARK: - Single Data Document Type Aliases

	typealias AlbumsSingleDataDocument = DataDocument<AlbumsResource>
	typealias ArtistsSingleDataDocument = DataDocument<ArtistsResource>
	typealias ArtistRolesSingleDataDocument = DataDocument<ArtistRolesResource>
	typealias ArtworksSingleDataDocument = DataDocument<ArtworksResource>
	typealias PlaylistsSingleDataDocument = DataDocument<PlaylistsResource>
	typealias ProvidersSingleDataDocument = DataDocument<ProvidersResource>
	typealias SearchResultsSingleDataDocument = DataDocument<SearchResultsResource>
	typealias SearchSuggestionsSingleDataDocument = DataDocument<SearchSuggestionsResource>
	typealias TracksSingleDataDocument = DataDocument<TracksResource>
	typealias TrackFilesSingleDataDocument = DataDocument<TrackFilesResource>
	typealias TrackManifestsSingleDataDocument = DataDocument<TrackManifestsResource>
	typealias UsersSingleDataDocument = DataDocument<UsersResource>
	typealias UserCollectionsSingleDataDocument = DataDocument<UserCollectionsResource>
	typealias UserEntitlementsSingleDataDocument = DataDocument<UserEntitlementsResource>
	typealias UserRecommendationsSingleDataDocument = DataDocument<UserRecommendationsResource>
	typealias UserReportsSingleDataDocument = DataDocument<UserReportsResource>
	typealias VideosSingleDataDocument = DataDocument<VideosResource>

	// MARK: - Single Data Relationship Document Type Aliases

	typealias SingletonDataRelationshipDoc = DataDocument<ResourceIdentifier>

	// MARK: - Multi Data Document Type Aliases

	typealias AlbumsMultiDataDocument = DataDocument<[AlbumsResource]>
	typealias ArtistsMultiDataDocument = DataDocument<[ArtistsResource]>
	typealias ArtistRolesMultiDataDocument = DataDocument<[ArtistRolesResource]>
	typealias ArtworksMultiDataDocument = DataDocument<[ArtworksResource]>
	typealias PlaylistsMultiDataDocument = DataDocument<[PlaylistsResource]>
	typealias ProvidersMultiDataDocument = DataDocument<[ProvidersResource]>
	typealias SearchResultsMultiDataDocument = DataDocument<[SearchResultsResource]>
	typealias SearchSuggestionsMultiDataDocument = DataDocument<[SearchSuggestionsResource]>
	typealias TracksMultiDataDocument = DataDocument<[TracksResource]>
	typealias TrackFilesMultiDataDocument = DataDocument<[TrackFilesResource]>
	typealias TrackManifestsMultiDataDocument = DataDocument<[TrackManifestsResource]>
	typealias UsersMultiDataDocument = DataDocument<[UsersResource]>
	typealias UserCollectionsMultiDataDocument = DataDocument<[UserCollectionsResource]>
	typealias UserEntitlementsMultiDataDocument = DataDocument<[UserEntitlementsResource]>
	typealias UserRecommendationsMultiDataDocument = DataDocument<[UserRecommendationsResource]>
	typealias UserReportsMultiDataDocument = DataDocument<[UserReportsResource]>
	typealias VideosMultiDataDocument = DataDocument<[VideosResource]>

	// MARK: - Multi Data Relationship Document Type Aliases

	typealias MultiDataRelationshipDoc = DataDocument<[ResourceIdentifier]>
}
