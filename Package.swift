// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "advent-of-code-2024",
    platforms: [
        .macOS(.v10_15)  // swift-parsing requires this minimum, default appears to be 10_13
    ],
    products: [
        .library(name: "advent-of-code-2024", targets: ["advent-of-code-2024"])
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-parsing.git", from: "0.13.0"),
        .package(url: "https://github.com/swiftlang/swift-testing.git", branch: "main"),
    ],
    targets: [
        .target(
            name: "advent-of-code-2024",
            dependencies: [
                .product(name: "Parsing", package: "swift-parsing")
            ]
        ),
        .testTarget(
            name: "test",
            dependencies: [
                "advent-of-code-2024",
                .product(name: "Testing", package: "swift-testing"),
            ]
        ),
        .executableTarget(
            name: "main",
            dependencies: [
                "advent-of-code-2024"
            ]
        ),
    ]
)
