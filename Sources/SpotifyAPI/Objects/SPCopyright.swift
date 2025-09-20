import SwiftAPIClient

public struct SPCopyright: Codable, Sendable, Equatable {
	/// The copyright text for this album.
	public var text: String
	/// The type of copyright: C = the copyright, P = the sound recording (performance) copyright.
	public var type: String

	public init(text: String, type: String) {
		self.text = text
		self.type = type
	}
}

extension SPCopyright: Mockable {
	public static let mock = SPCopyright(
		text: "2023 Mock Records",
		type: "C"
	)
}
