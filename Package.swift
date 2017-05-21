// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Test",
    products: [
        .library(name: "Test", targets: ["Test"]),
    ],
    targets: [
        .target(name: "Test")
    ]
)
