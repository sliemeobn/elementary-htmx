// swift-tools-version: 5.10
import PackageDescription

let featureFlags: [SwiftSetting] = [
    .enableExperimentalFeature("StrictConcurrency=complete"),
    .enableUpcomingFeature("ExistentialAny"),
    .enableUpcomingFeature("ConciseMagicFile"),
    .enableUpcomingFeature("ImplicitOpenExistentials"),
]

let package = Package(
    name: "elementary-htmx",
    platforms: [
        .macOS(.v14),
        .iOS(.v17),
        .tvOS(.v17),
        .watchOS(.v10),
    ],
    products: [
        .library(
            name: "ElementaryHTMX",
            targets: ["ElementaryHTMX"]
        ),
        .library(
            name: "ElementaryHTMXSSE",
            targets: ["ElementaryHTMXSSE"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/sliemeobn/elementary.git", from: "0.1.1"),
    ],
    targets: [
        .target(
            name: "ElementaryHTMX",
            dependencies: [
                .product(name: "Elementary", package: "elementary"),
            ],
            swiftSettings: featureFlags
        ),
        .target(
            name: "ElementaryHTMXSSE",
            dependencies: [
                .product(name: "Elementary", package: "elementary"),
                .target(name: "ElementaryHTMX"),
            ],
            swiftSettings: featureFlags
        ),
        .testTarget(
            name: "ElementaryHTMXTest",
            dependencies: [
                .target(name: "ElementaryHTMX"),
            ],
            swiftSettings: featureFlags
        ),
    ]
)
