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
            Text(store.isLoading ? "✴︎" : "✴︎ \(store.usage.sessionPercentage)%")
                .task {
                    while !Task.isCancelled {
                        await store.refresh()
                        try? await Task.sleep(for: .seconds(300))
                    }
                }
        }.menuBarExtraStyle(.window)
    }
}
