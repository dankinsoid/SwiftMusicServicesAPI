// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "SwiftMusicServicesAPI",
  platforms: [
    .macOS(.v10_15),
    .iOS(.v13),
    .tvOS(.v13),
    .watchOS(.v6),
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
    .library(
      name: "YandexMusicAPI",
      targets: ["YandexMusicAPI"]
    ),
    .library(
      name: "YandexMusicLogin",
      targets: ["YandexMusicLogin"]
    ),
    .library(
      name: "VKMusicAPI",
      targets: ["VKMusicAPI"]
    ),
    .library(
      name: "VKLogin",
      targets: ["VKLogin"]
    ),
    .library(
      name: "AppleMusicAPI",
      targets: ["AppleMusicAPI"]
    ),
    .library(
      name: "AppleMusicLogin",
      targets: ["AppleMusicLogin"]
    ),
    .library(
      name: "AmazonMusicAPI",
      targets: ["AmazonMusicAPI"]
    ),
    .library(
      name: "YouTubeAPI",
      targets: ["YouTubeAPI"]
    ),
    .library(
      name: "YouTubeLogin",
      targets: ["YouTubeLogin"]
    ),
    .library(
      name: "SoundCloudAPI",
      targets: ["SoundCloudAPI"]
    ),
    .library(
      name: "TidalAPI",
      targets: ["TidalAPI"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/dankinsoid/VDCodable", from: "2.13.0"),
    .package(url: "https://github.com/dankinsoid/swift-api-client.git", from: "1.58.0"),
    .package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.4.0"),
    .package(url: "https://github.com/vapor/jwt-kit.git", from: "4.0.0"),
    .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "1.0.0")
  ],
  targets: [
    .target(
      name: "SwiftMusicServicesApi",
      dependencies: [
        .product(name: "VDCodable", package: "VDCodable"),
        .product(name: "SwiftAPIClient", package: "swift-api-client"),
        "CryptoSwift"
      ]
    ),
    .target(
      name: "SpotifyAPI",
      dependencies: [
        .target(name: "SwiftMusicServicesApi")
      ]
    ),
    .target(
      name: "SpotifyLogin",
      dependencies: [.target(name: "SpotifyAPI")]
    ),
    .testTarget(
      name: "SpotifyAPITests",
      dependencies: [
        .target(name: "SpotifyAPI")
      ]
    ),
    .target(
      name: "YandexMusicAPI",
      dependencies: [.target(name: "SwiftMusicServicesApi")]
    ),
    .target(
      name: "YandexMusicLogin",
      dependencies: [.target(name: "YandexMusicAPI")]
    ),
    .testTarget(
      name: "YandexMusicTests",
      dependencies: [
        .target(name: "YandexMusicAPI"),
        .target(name: "YandexMusicLogin"),
      ]
    ),
    .target(
      name: "VKMusicAPI",
      dependencies: [
        .target(name: "SwiftMusicServicesApi"),
        "SwiftSoup",
      ]
    ),
    .target(
      name: "VKLogin",
      dependencies: [
        .target(name: "VKMusicAPI")
      ]
    ),
    .testTarget(
      name: "VKMusicAPITests",
      dependencies: [
        .target(name: "VKMusicAPI"),
        .target(name: "VKLogin"),
      ]
    ),
    .target(
      name: "AppleMusicAPI",
      dependencies: [
        "SwiftMusicServicesApi"
      ]
    ),
    .target(
      name: "AppleMusicLogin",
      dependencies: [
        .target(name: "AppleMusicAPI"),
        .product(name: "JWTKit", package: "jwt-kit"),
      ]
    ),
    .testTarget(
      name: "AppleMusicTests",
      dependencies: [
        .target(name: "AppleMusicAPI")
      ]
    ),
    .target(
      name: "AmazonMusicAPI",
      dependencies: [
        "SwiftMusicServicesApi"
      ]
    ),
		.testTarget(
		name: "AmazonMusicTests",
		dependencies: [
			.target(name: "AmazonMusicAPI"),
		]
	),
    .target(
      name: "YouTubeAPI",
      dependencies: [
        "SwiftMusicServicesApi"
      ]
    ),
    .target(
      name: "YouTubeLogin",
      dependencies: [.target(name: "YouTubeAPI")]
    ),
    .testTarget(
      name: "YouTubeAPITests",
      dependencies: [
        .target(name: "YouTubeAPI")
      ]
    ),
    .target(
      name: "SoundCloudAPI",
      dependencies: [
        "SwiftMusicServicesApi"
      ]
    ),
    .testTarget(
      name: "SoundCloudAPITests",
      dependencies: [
        .target(name: "SoundCloudAPI")
      ]
    ),
    .target(
      name: "TidalAPI",
      dependencies: [
        "SwiftMusicServicesApi"
      ]
    ),
    .testTarget(
      name: "TidalAPITests",
      dependencies: [
        .target(name: "TidalAPI")
      ]
    ),
  ]
)
