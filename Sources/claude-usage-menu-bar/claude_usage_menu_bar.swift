// The Swift Programming Language
// https://docs.swift.org/swift-book

@main
struct claude_usage_menu_bar {
    static func main() {
        print("Hello, world!")
        do {
            let output = try runClaudeUsage()
            print(output)
        } catch {
            print("invalid data error?")
        }
    }
}
