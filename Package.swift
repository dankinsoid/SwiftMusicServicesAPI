// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-music-services-api",
    products: [
      .library(
          name: "SwiftMusicServicesApi",
          targets: ["SwiftMusicServicesApi"]
      ),
    ],
    dependencies: [
      .package(url: "https://github.com/binarybirds/swift-http", from: "1.0.0"),
    ],
    targets: [
      .target(
          name: "SwiftMusicServicesApi",
          dependencies: [
            .product(name: "SwiftHttp", package: "swift-http"),
          ]
      ),
      .testTarget(
          name: "SwiftMusicServicesApiTests",
          dependencies: ["SwiftMusicServicesApi"]
      ),
    ]
)
