import Foundation
import Observation

@Observable
class UsageStore {
    private(set) var usage: Usage


    // TODO: change to "Loading" instead of initial state
    init() {
        usage = Usage(sessionPercentage: 0, weeklyPercentage: 0, sessionResetDate: nil, weeklyResetDate: nil, lastUpdated: Date())
    }

    func refresh() {
        do {
            let output = try runClaudeUsage()
            usage = try parseUsage(from: output)
        }
        catch {
            print(error)
        }
    }
}