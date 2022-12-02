// swift-tools-version: 5.7
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
	],
	dependencies: [
		.package(url: "https://github.com/BinaryBirds/swift-http.git", from: "1.1.0"),
		.package(url: "https://github.com/dankinsoid/VDCodable", from: "2.10.0"),
		.package(url: "https://github.com/scinfu/SwiftSoup.git", from: "2.4.0"),
		.package(url: "https://github.com/dankinsoid/MultipartFormDataKit.git", from: "1.0.2"),
		.package(url: "https://github.com/vapor/jwt-kit.git", from: "4.0.0"),
	],
	targets: [
		.target(
			name: "SwiftMusicServicesApi",
			dependencies: [
				.product(name: "SwiftHttp", package: "swift-http"),
				.product(name: "VDCodable", package: "VDCodable"),
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
				"SwiftSoup",
				"MultipartFormDataKit",
			]
		),
		.target(
			name: "VKLogin",
			dependencies: [.target(name: "VKMusicAPI")]
		),
		.target(
			name: "AppleMusicAPI",
			dependencies: [
				"SwiftMusicServicesApi",
			]
		),
		.target(
			name: "AppleMusicLogin",
			dependencies: [
				.target(name: "AppleMusicAPI"),
				.product(name: "JWTKit", package: "jwt-kit"),
			]
		),
	]
)
