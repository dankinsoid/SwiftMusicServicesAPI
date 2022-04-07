// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-music-services-api",
    platforms: [
      .macOS("10.15"),
      .iOS("13.0"),
      .tvOS("13.0"),
      .watchOS("6.0")
    ],
    products: [
      .library(
          name: "SpotifyAPI",
          targets: ["SpotifyAPI"]
      ),
			.library(
				name: "SpotifyLogin",
				targets: ["SpotifyLogin"]
			),
		],
    dependencies: [
      .package(url: "https://github.com/apple/swift-async-algorithms.git", from: "0.0.1"),
      .package(url: "https://github.com/dankinsoid/swift-http", from: "1.0.5"),
      .package(url: "https://github.com/dankinsoid/VDCodable", from: "2.10.0")
    ],
    targets: [
      .target(
          name: "SwiftMusicServicesApi",
          dependencies: [
            .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
            .product(name: "SwiftHttp", package: "swift-http"),
            .product(name: "VDCodable", package: "VDCodable")
          ]
      ),
      .target(
          name: "SpotifyAPI",
          dependencies: [.target(name: "SwiftMusicServicesApi")]
      ),
      .target(
          name: "SpotifyLogin",
          dependencies: []
      ),
      .testTarget(
          name: "SwiftMusicServicesApiTests",
          dependencies: ["SwiftMusicServicesApi"]
      ),
    ]
)
