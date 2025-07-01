
// swiftlint:disable all
import Foundation
import SwiftAPIClient

public extension Tidal.API.V2.UserCollections {

  /**
   Get all userCollection.

   Retrieves all userCollection.

   **GET** /userCollections
   */
  func get(locale: String, countryCode: String? = nil, include: [Include]? = nil, id: String? = nil, fileID: String = #fileID, line: UInt = #line) async throws -> TDO.UserCollectionsSingleDataDocument {
    try await client
      .path("/userCollections")
      .method(.get)
      .query([
        "locale": locale,
        "countryCode": countryCode,
        "include": include,
        "filter[id]": id,
      ])
      .auth(enabled: true)
      .call(
        .http,
        as: .decodable,
        fileID: fileID,
        line: line
      )
  }

  enum Include: String, CaseIterable, Codable, Sendable, Equatable {
    case albums, artists, playlists
  }
}
