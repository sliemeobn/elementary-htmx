// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "HummingbirdDemo",
    platforms: [
        .macOS(.v14),
    ],
    products: [
        .executable(name: "App", targets: ["App"]),
    ],
    dependencies: [
        .package(url: "https://github.com/hummingbird-project/hummingbird.git", from: "2.0.0-rc.1"),
        .package(url: "https://github.com/hummingbird-community/hummingbird-elementary.git", from: "0.1.0-rc.1"),
        .package(path: "../../../"),
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Hummingbird", package: "hummingbird"),
                .product(name: "HummingbirdElementary", package: "hummingbird-elementary"),
                .product(name: "ElementaryHTMX", package: "elementary-htmx"),
                .product(name: "ElementaryHxSSE", package: "elementary-htmx"),
            ],
            resources: [
                .copy("Public"),
            ],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency=complete")]
        ),
    ]
)
