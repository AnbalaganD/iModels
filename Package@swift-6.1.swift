// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iModels",
    platforms: [
        .iOS(.v15),
        .watchOS(.v8),
        .visionOS(.v1),
        .tvOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "iModels",
            targets: ["iModels"]
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "iModels"
        ),
        .testTarget(
            name: "iModelsTests",
            dependencies: ["iModels"]
        )
    ],
    swiftLanguageModes: [.v6]
)
