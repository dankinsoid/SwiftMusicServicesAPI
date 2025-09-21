import Foundation

public struct ISO8601Duration: Codable, Hashable, CustomStringConvertible, Sendable {

	public var years: Int
	public var months: Int
	public var days: Int
	public var hours: Int
	public var minutes: Int
	public var seconds: Double

	public init(years: Int = 0, months: Int = 0, days: Int = 0, hours: Int = 0, minutes: Int = 0, seconds: Double = 0) {
		self.years = years
		self.months = months
		self.days = days
		self.hours = hours
		self.minutes = minutes
		self.seconds = seconds
	}

	public init(from decoder: Decoder) throws {
		let container = try decoder.singleValueContainer()
		let durationString = try container.decode(String.self)
		self = try ISO8601Duration.parse(durationString)
	}

	public func encode(to encoder: Encoder) throws {
		var container = encoder.singleValueContainer()
		try container.encode(description)
	}

	public static func parse(_ string: String) throws -> ISO8601Duration {
		var duration = ISO8601Duration()

		let regex = try NSRegularExpression(pattern: "^P(?:([0-9]+)Y)?(?:([0-9]+)M)?(?:([0-9]+)D)?(?:T(?:([0-9]+)H)?(?:([0-9]+)M)?(?:([0-9]+(?:\\.[0-9]+)?)S)?)?$")
		if let match = regex.firstMatch(in: string, range: NSRange(string.startIndex..., in: string)) {
			if let yearsRange = Range(match.range(at: 1), in: string) {
				duration.years = Int(string[yearsRange]) ?? 0
			}
			if let monthsRange = Range(match.range(at: 2), in: string) {
				duration.months = Int(string[monthsRange]) ?? 0
			}
			if let daysRange = Range(match.range(at: 3), in: string) {
				duration.days = Int(string[daysRange]) ?? 0
			}
			if let hoursRange = Range(match.range(at: 4), in: string) {
				duration.hours = Int(string[hoursRange]) ?? 0
			}
			if let minutesRange = Range(match.range(at: 5), in: string) {
				duration.minutes = Int(string[minutesRange]) ?? 0
			}
			if let secondsRange = Range(match.range(at: 6), in: string) {
				duration.seconds = Double(string[secondsRange]) ?? 0
			}
		}

		return duration
	}

	public var description: String {
		var components = ["P"]
		if years > 0 { components.append("\(years)Y") }
		if months > 0 { components.append("\(months)M") }
		if days > 0 { components.append("\(days)D") }
		if hours > 0 || minutes > 0 || seconds > 0 {
			components.append("T")
			if hours > 0 { components.append("\(hours)H") }
			if minutes > 0 { components.append("\(minutes)M") }
			if seconds > 0 { components.append("\(seconds)S") }
		}
		return components.joined()
	}

	public var timeInterval: TimeInterval {
		let daysInYear = 365.25
		let daysInMonth = 30.44

		let totalDays = Double(years) * daysInYear + Double(months) * daysInMonth + Double(days)
		let totalHours = totalDays * 24 + Double(hours)
		let totalMinutes = totalHours * 60 + Double(minutes)
		let totalSeconds = totalMinutes * 60 + seconds

		return totalSeconds
	}
}
