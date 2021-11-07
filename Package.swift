// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CraigSiemensWebsite",
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(
            name: "Publish",
            url: "https://github.com/johnsundell/publish.git",
            from: "0.1.0"
        ),
        .package(
            name: "SplashPublishPlugin",
            url: "https://github.com/johnsundell/splashpublishplugin",
            from: "0.1.0"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CraigSiemensWebsite",
            dependencies: [
                "Publish",
                "SplashPublishPlugin"
            ]),
        .testTarget(
            name: "CraigSiemensWebsiteTests",
            dependencies: ["CraigSiemensWebsite"]),
    ]
)
