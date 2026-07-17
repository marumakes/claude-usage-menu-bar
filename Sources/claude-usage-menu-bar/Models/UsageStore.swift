import Foundation
import Observation

@MainActor
@Observable
class UsageStore {
    private(set) var usage: Usage
    private(set) var isLoading = true
    private(set) var errorMessage: String?

    init() {
        usage = Usage(sessionPercentage: 0, weeklyPercentage: 0, sessionResetDate: nil, weeklyResetDate: nil, lastUpdated: Date())
    }

    func refresh() async {
        var lastError: (any Error)? = ClaudeError.unknown
        for attempt in 0..<3 {
            do {
                let newUsage = try await Task.detached { () throws -> Usage in
                    let output = try runClaudeUsage()
                    return try parseUsage(from: output)
                }.value
                usage = newUsage
                errorMessage = nil
                isLoading = false
                return
            } catch {
                lastError = error
                if attempt < 2 { try? await Task.sleep(for: .milliseconds(300))}
            }
        }
        errorMessage = lastError?.localizedDescription ?? "Something went wrong"
        isLoading = false
    }
}