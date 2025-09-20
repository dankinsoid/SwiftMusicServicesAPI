import Foundation

public extension AppleMusic.API {

	func storefront(
		language: String? = nil,
		include: [String]? = nil
	) async throws -> AppleMusic.Objects.Storefront {
		let value = try await client("v1", "me", "storefront")
			.query(["l": language, "include": include])
			.call(.http, as: .decodable(AppleMusic.Objects.Response<AppleMusic.Objects.Item>.self))
			.data.last
		guard let value else {
			throw NoStorefront()
		}
		return AppleMusic.Objects.Storefront(
			id: value.id,
			name: value.attributes?.name,
			supportedLanguageTags: value.attributes?.supportedLanguageTags ?? [],
			defaultLanguageTag: value.attributes?.defaultLanguageTag
		)
	}
}

private struct NoStorefront: Error {}

public extension AppleMusic.Objects {

	struct Storefront: Codable, Equatable, Identifiable {

		public var id: String
		public var supportedLanguageTags: [String]
		public var defaultLanguageTag: String?
		public var name: String?

		public init(id: String, name: String?, supportedLanguageTags: [String], defaultLanguageTag: String?) {
			self.id = id
			self.supportedLanguageTags = supportedLanguageTags
			self.defaultLanguageTag = defaultLanguageTag
			self.name = name
		}
	}
}
