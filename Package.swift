// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "scheduler-kit",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13)
    ],
    products: [
        .library(name: "scheduler-kit", targets: ["scheduler-kit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "scheduler-kit",
            dependencies: []
        ),
        .testTarget(
            name: "scheduler-kitTests",
            dependencies: ["scheduler-kit"]
        ),
    ]
)
