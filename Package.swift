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
    ],
    dependencies: [
        .package(url: "https://github.com/sliemeobn/elementary.git", .upToNextMajor(from: "0.1.0-beta.7")),
    ],
    targets: [
        .target(
            name: "ElementaryHTMX",
            dependencies: [
                .product(name: "Elementary", package: "elementary"),
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
