import Foundation

enum ClaudeError: Error {
    case invalidData
    case missingLine(String)
    case invalidPercentage
    case invalidDate
    case processFailed
    case commandNotFound
    case unknown
}

extension ClaudeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidData: return "Couldn't read output from the Claude CLI."
        case .missingLine(let line): return "Couldn't find \"\(line)\" in the usage output."
        case .invalidPercentage: return "Couldn't parse a usage percentage."
        case .invalidDate: return "Couldn't parse a reset date."
        case .processFailed: return "The Claude CLI process failed to run."
        case .commandNotFound: return "Claude CLI not found."
        case .unknown: return "Something went wrong."
        }
    }
}


// runs a terminal command to access to the Claude CLI, and returns the usage data
func runClaudeUsage() throws -> String {
    // create process
    let task = Process()
    let outputPipe = Pipe()
    let errorPipe = Pipe()
    
    // send anything the process prints to stdout into this pipe instead of the terminal
    task.standardOutput = outputPipe
    task.standardError = errorPipe

    // call claude cli with /usage arg
    task.arguments = ["-p", "/usage"]
    task.executableURL = URL(fileURLWithPath: "/opt/homebrew/bin/claude")

    try task.run()
    task.waitUntilExit()
    
    let data = outputPipe.fileHandleForReading.readDataToEndOfFile()

    guard let output = String(data: data, encoding: .utf8) else {
        throw ClaudeError.invalidData
    }
    
    // return the result
    return output        
}

