// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "multipart",
    platforms: [.macOS(.v13), .iOS(.v16), .tvOS(.v13), .visionOS(.v1)],
    products: [
        .library(name: "MultipartClient", targets: ["MultipartClient"]),
        .executable(name: "MultipartCli", targets: ["MultipartCli"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-openapi-generator", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-openapi-runtime", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-openapi-urlsession", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "MultipartClient",
            dependencies: [
                .product(name: "OpenAPIRuntime", package: "swift-openapi-runtime"),
                .product(name: "OpenAPIURLSession", package: "swift-openapi-urlsession")
            ],
            plugins: [
                .plugin(name: "OpenAPIGenerator", package: "swift-openapi-generator"),
            ]
        ),
        .executableTarget(
            name: "MultipartCli",
            dependencies: [
                "MultipartClient",
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ],
            path: "Sources/MultipartCli"
        )
    ]
)
