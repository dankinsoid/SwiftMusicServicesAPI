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
		],
    dependencies: [
      .package(url: "https://github.com/apple/swift-async-algorithms.git", from: "0.0.1"),
      .package(url: "https://github.com/dankinsoid/swift-http", from: "1.0.5"),
      .package(url: "https://github.com/dankinsoid/VDCodable", from: "2.10.0"),
			.package(url: "https://github.com/Kitura/swift-html-entities.git", from: "3.0.0"),
			.package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.4.0"),
			.package(url: "https://github.com/Kuniwak/MultipartFormDataKit.git", from: "1.0.1"),
			.package(url: "https://github.com/vapor/jwt-kit.git", from: "4.0.0")
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
      .target(
          name: "YandexMusicAPI",
          dependencies: [.target(name: "SwiftMusicServicesApi")]
      ),
			.target(
				name: "YandexMusicLogin",
				dependencies: [.target(name: "YandexMusicAPI")]
			),
			.target(
					name: "VKMusicAPI",
					dependencies: [
						.target(name: "SwiftMusicServicesApi"),
						.product(name: "HTMLEntities", package: "swift-html-entities"),
						"SwiftSoup",
						"MultipartFormDataKit"
					]
			),
			.target(
					name: "VKLogin",
					dependencies: [.target(name: "VKMusicAPI")]
			),
      .testTarget(
          name: "SwiftMusicServicesApiTests",
          dependencies: ["SwiftMusicServicesApi"]
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
						.product(name: "JWTKit", package: "jwt-kit")
					]
			),
    ]
)
