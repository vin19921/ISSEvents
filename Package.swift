// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ISSEvents",
    platforms: [.iOS(.v14)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ISSEvents",
            targets: ["ISSEvents"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/vin19921/ThemeKitIOS", branch: "develop"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ISSEvents",
            dependencies: [.product(name: "ISSTheme", package: "ThemeKitIOS"),]),
        .testTarget(
            name: "ISSEventsTests",
            dependencies: ["ISSEvents"]),
    ]
)
