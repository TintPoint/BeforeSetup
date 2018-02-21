// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BeforeSetup",
    dependencies: [
        .package(url: "https://github.com/apollographql/apollo-ios", from: "0.7.0"),
        .package(url: "https://github.com/jpsim/yams", from: "0.5.0")
    ],
    targets: [
        .target(
            name: "BeforeSetup",
            dependencies: ["Apollo", "Yams"]
        )
    ]
)
