// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "CarbonGraph",
    platforms: [.iOS(.v9)],
    products: [
        .library(
            name: "CarbonCore",
            targets: ["CarbonCore"]
        ),
        .library(
            name: "CarbonObjC",
            targets: ["CarbonObjC"]
        ),
    ],
    targets: [
        .target(
            name: "CarbonCore",
            path: "CarbonCore/CarbonCore"
        ),
        .target(
            name: "CarbonObjC",
            dependencies: ["CarbonCore"],
            path: "CarbonObjC/CarbonObjC"
        )
    ],
    swiftLanguageVersions: [.v5]
)
