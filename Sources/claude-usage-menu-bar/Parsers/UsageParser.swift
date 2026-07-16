import Foundation

func parseUsage(from output: String) throws -> Usage {
    let sessionLine = try findLine(startingWith: "Current session", in: output)
    let sessionPercentage = try parsePercentage(from: sessionLine)
    let sessionResetDate = (sessionPercentage > 0 ? try parseResetDate(from: sessionLine) : nil)
    

    let weekLine = try findLine(startingWith: "Current week (all models)", in: output)
    let weeklyPercentage = try parsePercentage(from: weekLine)
    let weeklyResetDate = (weeklyPercentage > 0 ? try parseResetDate(from: weekLine) : nil)

    return Usage(sessionPercentage: sessionPercentage, weeklyPercentage: weeklyPercentage, sessionResetDate: sessionResetDate, weeklyResetDate: weeklyResetDate, lastUpdated: Date()) 
}

func findLine(startingWith prefix: String, in output: String) throws -> String {
   let lines = output.split(separator: "\n")
    guard let line = lines.first(where: { $0.hasPrefix(prefix) }) else {
        throw ClaudeError.missingLine(prefix)
    }
    return String(line)
}


/// - Parameter line: format is "Current session: 8% used · resets Jul 13 at 9:59pm (Asia/Seoul)"
/// - Throws: ClaudeError.invalidPercentage
/// - Returns: Integer percentage
func parsePercentage(from line: String) throws -> Int { 
    let colonParts = line.split(separator: ":")
    guard colonParts.count > 1 else {
        throw ClaudeError.invalidPercentage
    }

    let percentageParts: [String.SubSequence] = colonParts[1].split(separator: "%")
    guard percentageParts.count > 1 else {
        throw ClaudeError.invalidPercentage
    }
   
    let percentageText = percentageParts[0].trimmingCharacters(in: .whitespaces)
    guard let percentage = Int(percentageText) else {
        throw ClaudeError.invalidPercentage
    }
    return percentage
}


/// - Parameter line: format is "Current session: 8% used · resets Jul 13 at 9:59pm (Asia/Seoul)"
/// - Throws: ClaudeError.invalidDate
/// - Returns: Date
/// TODO: add guard for new year's eve (year)
func parseResetDate(from line: String) throws -> Date {
    guard let match = line.firstMatch(of: /.+?\s+resets\s+(.+?)\s+\(/) else {
        throw ClaudeError.invalidDate
    }

    let dateText = String(match.output.1)   // e.g. "Jul 13 at 9:59pm"

    let currentYear = String(Calendar.current.component(.year, from: Date()))
    let dateString = "\(currentYear) \(dateText)"

    let formatter = DateFormatter() 
    formatter.locale = Locale(identifier: "en_US_POSIX")

    if dateString.contains(":") {
        formatter.dateFormat = "yyyy MMM d 'at' h:mma"
    } else {
        formatter.dateFormat = "yyyy MMM d 'at' ha"
    }

    guard let date = formatter.date(from: dateString) else {
            throw ClaudeError.invalidDate
        }

    return date
} 