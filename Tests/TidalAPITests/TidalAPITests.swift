import Foundation
@testable import TidalAPI
import SwiftAPIClient
import XCTest

final class TidalAPITests: XCTestCase {
	
	var api = Tidal.API.V2(
		client: APIClient().loggingComponents(.full),
		clientID: "",
		clientSecret: "=",
		redirectURI: Tidal.Auth.redirectURIDesktop,
		defaultCountryCode: "NL",
		tokens: nil
	)
	
	var apiV1 = Tidal.API.V1(
		client: APIClient().loggingComponents(.full),
		clientID: "",
		clientSecret: "",
		redirectURI: Tidal.Auth.redirectURIDesktop,
		defaultCountryCode: "NL",
		tokens: nil
	)
	
	func testUsers() async throws {
		do {
			let hm = try await api.client.path("userCollections/198537731")
				.query("include", "likes")
				.get()
		 print(hm)
		 //			let user = try await api.users.getMe() // 198537731
		 //			print(user.data!.id)
			let playlists = try await api.userCollections.getByIdRelationshipsPlaylists(id: "198537731")
//			let id = playlists.included![0].playlists!.id
//			print(id)
//			try await api.playlists.getBy/IdRelationshipsItems(id: id)
			
//								let playlists = try await api.playlists.get(ownersId: [user.data!.id])
			//					print(tracks)
		} catch {
			print(error)
			throw error
		}
	}
	
	func testISRC() async throws {
		let tracks = try await api.tracks.get(include: [.artists], isrc: ["USIR19902111"])
//		print(tracks.data?.count ?? 0, tracks.included?.count ?? 0)
//		print(tracks.data?.map { $0.relationships?.artists.included?.count })
//		print(tracks.included?.compactMap { $0.artists } ?? [])
	}
	
	func testSearch() async throws {
		do {
			let tracks = try await api.searchResults.getById(id: "Coyle Girelli Isabella Dances", include: [.tracks])
			let ids = tracks.included?.compactMap { $0.tracks?.id } ?? []
			let track = try await api.tracks.getById(id: ids[0], include: [.artists])
			//		print(track.included!.compactMap { $0.artists?.attributes?.name })
			//
			//		try await apiV1.tracks(ids[0]).playbackInfo()
			//		api.client
			//			.url("https://api.tidal.com/v1/tracks/\(ids[0])/playbackinfo")
			//			.query([
			//				"audioquality": "HIGH",
			//				"assetpresentation": "FULL",
			//				"playbackmode": "STREAM",
			//				"immersiveaudio": "false"
			//			])
			//			.get()
		} catch {
			XCTFail("\(error)")
		}
	}
	
	func testCreatePlaylist() async throws {
		//        let playlist = try await api.users(198537731).playlists.create(title: "Test 2")
		//        print(playlist)
	}
}
