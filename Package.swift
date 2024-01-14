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
            swiftSettings: swift6
        ),
        .executableTarget(
            name: "Tests/Test",
            dependencies: ["Test"],
            path: "Tests/Test",
            swiftSettings: swift6
        ),
    ]
)

let swift6: [SwiftSetting] = [
    .enableUpcomingFeature("ConciseMagicFile"),
    .enableUpcomingFeature("ForwardTrailingClosures"),
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("StrictConcurrency"),
    .enableUpcomingFeature("ImplicitOpenExistentials"),
    .enableUpcomingFeature("BareSlashRegexLiterals"),
]
