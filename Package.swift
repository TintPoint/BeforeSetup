// swift-tools-version:4.2

import PackageDescription

let package = Package(
    name: "BeforeSetup",
    dependencies: [
        .package(url: "https://github.com/apollographql/apollo-ios", from: "0.9.0"),
        .package(url: "https://github.com/jpsim/yams", from: "1.0.0"),
        .package(url: "https://github.com/kishikawakatsumi/keychainaccess", from: "3.1.0"),
    ],
    targets: [
        .target(name: "BeforeSetup", dependencies: ["Apollo", "Yams", "KeychainAccess"]),
    ],
    swiftLanguageVersions: [
        .v4_2,
    ]
)
