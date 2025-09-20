import Foundation

package extension String {

	static func query(params: [String: String?]) -> String {
		params.compactMap { key, value in
			guard
				let value = value?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowedRFC3986),
				let key = key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowedRFC3986)
			else {
				return nil
			}
			return "\(key)=\(value)"
		}
		.joined(separator: "&")
	}
}

package extension Data {

	static func formURL(params: [String: String?]) -> Data? {
		String.query(params: params).data(using: .utf8)
	}
}

package extension CharacterSet {

	/// Creates a CharacterSet from RFC 3986 allowed characters.
	///
	/// RFC 3986 states that the following characters are "reserved" characters.
	///
	/// - General Delimiters: ":", "#", "[", "]", "@", "?", "/"
	/// - Sub-Delimiters: "!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="
	///
	/// In RFC 3986 - Section 3.4, it states that the "?" and "/" characters should not be escaped to allow
	/// query strings to include a URL. Therefore, all "reserved" characters with the exception of "?" and "/"
	/// should be percent-escaped in the query string.
	static let urlQueryAllowedRFC3986: CharacterSet = {
		let encodableDelimiters = CharacterSet(charactersIn: ":#[]@!$&'()*+,;=")
		return CharacterSet.urlQueryAllowed.subtracting(encodableDelimiters)
	}()
}
