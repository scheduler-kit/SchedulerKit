// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SchedulerKit",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .watchOS(.v6),
        .tvOS(.v13)
    ],
    products: [
        .library(
            name: "SchedulerKit",
            type: .dynamic,
            targets: ["SchedulerKit"]
        ),
        .library(
            name: "SchedulerKitTestUtils",
            type: .dynamic,
            targets: ["SchedulerKitTestUtils"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "SchedulerKit",
            dependencies: []
        ),
        .target(
            name: "SchedulerKitTestUtils",
            dependencies: ["SchedulerKit"]
        ),
        .testTarget(
            name: "SchedulerKitTests",
            dependencies: ["SchedulerKit", "SchedulerKitTestUtils"]
        ),
    ]
)
