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
        .package(url: "https://github.com/vapor/vapor", from: "4.102.0"),
        .package(url: "https://github.com/vapor-community/vapor-elementary.git", from: "0.1.0"),
        .package(path: "../../../"),
    ],
    targets: [
        .executableTarget(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "VaporElementary", package: "vapor-elementary"),
                .product(name: "ElementaryHTMX", package: "elementary-htmx"),
            ],
            resources: [
                .copy("Public"),
            ],
            swiftSettings: [.enableExperimentalFeature("StrictConcurrency=complete")]
        ),
    ]
)
