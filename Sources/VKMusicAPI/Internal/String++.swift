import Foundation

extension String {
    
    func firstGroup(of regex: String) -> String? {
        guard let regex = try? NSRegularExpression(pattern: regex) else {
            return nil
        }
        
        guard let match = regex.firstMatch(in: self, range: NSRange(location: 0, length: count)) else {
            return nil
        }
        let range = (0 ..< match.numberOfRanges).first {
            match.range(at: $0) != match.range
        }.map {
            match.range(at: $0)
        } ?? match.range
        let start = index(startIndex, offsetBy: range.location)
        let end = index(startIndex, offsetBy: range.location + range.length)
        return String(self[start ..< end])
    }
}
