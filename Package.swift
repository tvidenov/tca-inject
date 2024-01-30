// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "tca-inject",
    platforms: [
         .iOS(.v17)
       ],
       products: [
         .library(name: "AppFeature", targets: ["AppFeature"]),
         .library(name: "MainFeature", targets: ["MainFeature"]),
         .library(name: "SecondFeature", targets: ["SecondFeature"])
       ],
       dependencies: [
         .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.7.0"),
         .package(url: "https://github.com/krzysztofzablocki/Inject.git", from: "1.3.0")
         ],
    targets: [
            .target(
                name: "AppFeature",
                dependencies: [
                  "MainFeature",
                  "SecondFeature",
                  "Inject",
                  .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
                ]
            ),
            .target(
                name: "MainFeature",
                dependencies: [
                  "Inject",
                  .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
                ]
            ),
            .target(
                name: "SecondFeature",
                dependencies: [
                  "Inject",
                  .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
                ]
            )
        ],
        swiftLanguageVersions: [.v5]
)
