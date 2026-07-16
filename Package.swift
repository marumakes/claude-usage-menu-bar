// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "claude-usage-menu-bar",
    platforms: [
        .macOS(.v15)
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "claude-usage-menu-bar"
        ),
        .testTarget(
            name: "claude-usage-menu-barTests",
            dependencies: ["claude-usage-menu-bar"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
