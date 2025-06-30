import Foundation
import SwiftAPIClient
import SwiftMusicServicesApi

public extension Tidal.API.V1 {

    var tracks: Tracks {
        Tracks(client: client("tracks"))
    }

    struct Tracks {

        public let client: APIClient

        public func callAsFunction(_ id: Int) -> Tidal.API.V1.Track {
            Tidal.API.V1.Track(client: client(id))
        }
    }

    struct Track {

        public let client: APIClient
    }
}

public extension Tidal.API.V1.Tracks {

    func isrc(
        _ isrc: String,
        auth: Bool = true,
        limit: Int? = nil
    ) async throws -> [Tidal.Objects.Track] {
        try await TidalPaging<Tidal.Objects.Track>(client: client.query("isrc", isrc), limit: limit, offset: 0)
            .first()
            .items
    }
}

public extension Tidal.API.V1.Track {

    func playbackInfoPostPaywall(
        quality: Tidal.Objects.AudioQuality = .high,
        mode: Tidal.Objects.PlaybackMode = .stream,
        assetPresentation: Tidal.Objects.AssetPresentation = .full
    ) async throws -> Tidal.Objects.PlaybackInfo {
        try await client("playbackinfopostpaywall")
            .query([
                "audioquality": quality,
                "playbackmode": mode,
                "assetpresentation": assetPresentation,
            ])
            .call()
    }

    func playbackInfoPrePaywall() async throws -> Tidal.Objects.PlaybackInfo {
        try await client("playbackinfoprepaywall")
            .query([
                "audioquality": "LOW",
                "playbackmode": "STREAM",
                "assetpresentation": "PREVIEW",
            ])
            .call()
    }
}

public extension Tidal.Objects {

    struct PlaybackInfo: Codable, Equatable, Sendable {

        public var trackId: Int
        public var assetPresentation: AssetPresentation
        public var audioMode: AudioMode
        public var audioQuality: AudioQuality
        public var manifestMimeType: MimeType
        public var manifest: Data

        public init(
            trackId: Int,
            assetPresentation: AssetPresentation,
            audioMode: AudioMode,
            audioQuality: AudioQuality,
            manifestMimeType: MimeType,
            manifest: Data
        ) {
            self.trackId = trackId
            self.assetPresentation = assetPresentation
            self.audioMode = audioMode
            self.audioQuality = audioQuality
            self.manifestMimeType = manifestMimeType
            self.manifest = manifest
        }

        public func urls() throws -> [URL] {
            switch manifestMimeType {
            case .vndTidalBts:
                return try JSONDecoder().decode(VndTidalBtsManifest.self, from: manifest).urls
            default:
                guard let string = String(data: manifest, encoding: .utf8) else { throw ManifestDecodingError.invalidString }
                return string.components(separatedBy: "media=\"")
                    .dropFirst()
                    .compactMap {
                        $0.components(separatedBy: "\"").first.flatMap {
                            URL(string: $0)
                        }
                    }
            }
        }

        public struct MimeType: StringWrapper {

            public var description: String
            public init(_ value: String) { description = value }

            public static let vndTidalBts = MimeType("application/vnd.tidal.bts")
            public static let dashXml = MimeType("application/dash+xml")
        }

        public struct VndTidalBtsManifest: Codable, Equatable, Sendable {

            public var mimeType: String
            public var codecs: String
            public var encryptionType: String
            public var urls: [URL]

            public init(
                mimeType: String,
                codecs: String,
                encryptionType: String,
                urls: [URL]
            ) {
                self.mimeType = mimeType
                self.codecs = codecs
                self.encryptionType = encryptionType
                self.urls = urls
            }
        }
    }

    struct AudioQuality: StringWrapper {

        public var description: String
        public init(_ value: String) { description = value }

        /// 96kbps AAC
        public static let low = AudioQuality("LOW")
        /// 320kbps AAC
        public static let high = AudioQuality("HIGH")
        /// 1411kbps|16bit/44.1kHz FLAC/ALAC
        public static let lossless = AudioQuality("LOSSLESS")
        /// 24bit/96kHz MQA encoded FLAC
        public static let hiRes = AudioQuality("HI_RES")
    }

    enum PlaybackMode: String, CaseIterable, Equatable, Codable {

        case stream = "STREAM"
        case offline = "OFFLINE"
    }

    struct AudioMode: StringWrapper {

        public var description: String
        public init(_ value: String) { description = value }

        public static let stereo = AudioMode("STEREO")
    }

    struct AssetPresentation: StringWrapper {

        public var description: String
        public init(_ value: String) { description = value }

        public static let full = AssetPresentation("FULL")
        public static let preview = AssetPresentation("PREVIEW")
    }
}

private enum ManifestDecodingError: Error {

    case invalidString
}
