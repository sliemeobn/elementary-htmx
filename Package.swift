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
        .library(name: "ElementaryHTMX", targets: ["ElementaryHTMX"]),
        .library(name: "ElementaryHTMXSSE", targets: ["ElementaryHTMXSSE"]),
        .library(name: "ElementaryHTMXWS", targets: ["ElementaryHTMXWS"]),
        .library(name: "ElementaryHyperscript", targets: ["ElementaryHyperscript"]]
    ],
    dependencies: [
        .package(url: "https://github.com/sliemeobn/elementary.git", from: "0.3.0"),
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
        .target(
            name: "ElementaryHTMXWS",
            dependencies: [
                .product(name: "Elementary", package: "elementary"),
                .target(name: "ElementaryHTMX"),
            ],
            swiftSettings: featureFlags
        ),
        .target(
            name: "ElementaryHyperscript",
            dependencies: [
                .product(name: "Elementary", package: "elementary"),
                .target(name: "ElementaryHTMX"),
            ],
            swiftSettings: featureFlags
        ),
        .testTarget(
            name: "TestUtilities",
            dependencies: [
                .product(name: "Elementary", package: "elementary"),
            ],
            swiftSettings: featureFlags
        ),
        .testTarget(
            name: "ElementaryHTMXTest",
            dependencies: [
                .target(name: "ElementaryHTMX"),
                .target(name: "TestUtilities"),
            ],
            swiftSettings: featureFlags
        ),
        .testTarget(
            name: "ElementaryHTMXSSETest",
            dependencies: [
                .target(name: "ElementaryHTMXSSE"),
                .target(name: "TestUtilities"),
            ],
            swiftSettings: featureFlags
        ),
        .testTarget(
            name: "ElementaryHTMXWSTest",
            dependencies: [
                .target(name: "ElementaryHTMXWS"),
                .target(name: "TestUtilities"),
            ],
            swiftSettings: featureFlags
        ),
        .testTarget(
            name: "ElementaryHyperscriptTest",
            dependencies: [
                .target(name: "ElementaryHyperscript"),
                .target(name: "TestUtilities"),
            ],
            swiftSettings: featureFlags
        ),
    ]
)
