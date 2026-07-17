import SwiftUI
import AppKit

struct MenuBarView: View {
    let store: UsageStore

    var body: some View {
        VStack (alignment: .leading) {
            if store.isLoading {
                Text("Loading...")
            } else {
                Text("Current session: \(store.usage.sessionPercentage)%")
                if let sessionResetDate = store.usage.sessionResetDate {
                    Text("Resets \(formatResetDate(sessionResetDate))").foregroundStyle(.secondary)
                } 
                else {
                    Text("No active session").foregroundStyle(.secondary)
                }

                Divider()

                Text("Current week: \(store.usage.weeklyPercentage)%")            
                if let weeklyResetDate = store.usage.weeklyResetDate {
                                Text("Resets \(formatResetDate(weeklyResetDate))").foregroundStyle(.secondary)
                }

                if let errorMessage = store.errorMessage {
                    Text(errorMessage).foregroundStyle(.red).foregroundStyle(.secondary)
                }

                Divider()
                
                HStack{
                    Button("Refresh") {
                        store.refresh()
                    } 

                    Button("Quit") {
                        NSApplication.shared.terminate(nil)
                    
                    }      
                }
            }
        }
        .padding(8)
        .frame(maxWidth: 220)
    }
}
