
/** Filters content by level of access the user (logged in or anonymous) has to the track. The result list will include only tracks with the specified access. Include all options if you'd like to see all possible tracks. See `Track#access` schema for more details.
 */
public enum AccessExplicit: String, Codable, Equatable, CaseIterable, CustomStringConvertible {
	case playable
	case preview
	case blocked
	case undecoded

	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let rawValue = try container.decode(String.self)
		self = AccessExplicit(rawValue: rawValue) ?? .undecoded
	}

	public var description: String { rawValue }
}
