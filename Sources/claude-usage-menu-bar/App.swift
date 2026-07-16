// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI


@main
struct claude_usage_menu_bar: App {
    @State private var store = UsageStore()
    
   
    var body: some Scene {
        MenuBarExtra {
            MenuBarView(store: store)
        } label: {
            Text("CC: \(store.usage.sessionPercentage)%")
                .task {
                    while !Task.isCancelled {
                        store.refresh()
                        try? await Task.sleep(for: .seconds(300))
                    }
                }
        }
    }
}
