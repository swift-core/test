// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "Test",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
    ],
    products: [
        .library(
            name: "Test",
            targets: ["Test"]),
    ],
    targets: [
        .target(
            name: "Test",
            swiftSettings: [
                .enableUpcomingFeature("ConciseMagicFile")
            ]
        ),
        .executableTarget(
            name: "Tests/Test",
            dependencies: ["Test"],
            path: "Tests/Test"
        ),
    ]
)
