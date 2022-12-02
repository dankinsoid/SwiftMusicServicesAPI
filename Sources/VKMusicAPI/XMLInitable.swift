import SwiftSoup

public protocol XMLInitable {
	init(xml: SwiftSoup.Element) throws
}
