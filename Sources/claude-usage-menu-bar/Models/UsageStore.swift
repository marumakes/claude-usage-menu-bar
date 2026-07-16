import Foundation
import Observation

@Observable
class UsageStore {
    private(set) var usage: Usage
    private(set) var isLoading = true
    private(set) var errorMessage: String?

    init() {
        usage = Usage(sessionPercentage: 0, weeklyPercentage: 0, sessionResetDate: nil, weeklyResetDate: nil, lastUpdated: Date())
    }

    func refresh() {
        do {
            let output = try runClaudeUsage()
            usage = try parseUsage(from: output)
            errorMessage = nil
            isLoading = false
        }
        catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
}