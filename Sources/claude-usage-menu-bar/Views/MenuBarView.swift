import SwiftUI

struct MenuBarView: View {
    let store: UsageStore

    var body: some View {
        VStack{
            Text("Current session: \(store.usage.sessionPercentage)%")
            if let sessionResetDate = store.usage.sessionResetDate {
                Text("Resets \(formatResetDate(sessionResetDate))")
            } 
            else {
                Text("No active session")
            }

            Text("Current week: \(store.usage.weeklyPercentage)%")            
            if let weeklyResetDate = store.usage.weeklyResetDate {
                            Text("Resets \(formatResetDate(weeklyResetDate))")
            }        
        }
    }
}
