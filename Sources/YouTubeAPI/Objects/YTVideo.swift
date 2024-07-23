import Foundation
import SwiftMusicServicesApi

extension YouTube.Objects {
    
    public struct Video: Codable, Equatable {
        public var kind: String?
        public var etag: String?
        public var id: String?
        public var snippet: Snippet?
        public var contentDetails: ContentDetails?
        public var status: Status?
        public var statistics: Statistics?
        public var player: YTO.Player?
        public var topicDetails: TopicDetails?
        public var recordingDetails: RecordingDetails?
        public var fileDetails: FileDetails?
        public var processingDetails: ProcessingDetails?
        public var suggestions: Suggestions?
        public var liveStreamingDetails: LiveStreamingDetails?
        public var localizations: [String: YTO.Localization]?
        
        public init(kind: String? = nil, etag: String? = nil, id: String? = nil, snippet: Snippet? = nil, contentDetails: ContentDetails? = nil, status: Status? = nil, statistics: Statistics? = nil, player: YTO.Player? = nil, topicDetails: TopicDetails? = nil, recordingDetails: RecordingDetails? = nil, fileDetails: FileDetails? = nil, processingDetails: ProcessingDetails? = nil, suggestions: Suggestions? = nil, liveStreamingDetails: LiveStreamingDetails? = nil, localizations: [String: YTO.Localization]? = nil) {
            self.kind = kind
            self.etag = etag
            self.id = id
            self.snippet = snippet
            self.contentDetails = contentDetails
            self.status = status
            self.statistics = statistics
            self.player = player
            self.topicDetails = topicDetails
            self.recordingDetails = recordingDetails
            self.fileDetails = fileDetails
            self.processingDetails = processingDetails
            self.suggestions = suggestions
            self.liveStreamingDetails = liveStreamingDetails
            self.localizations = localizations
        }
        
        public enum CodingKeys: String, CodingKey, CaseIterable, Hashable, Codable {
            case kind
            case etag
            case id
            case snippet
            case contentDetails
            case status
            case statistics
            case player
            case topicDetails
            case recordingDetails
            case fileDetails
            case processingDetails
            case suggestions
            case liveStreamingDetails
            case localizations
        }
        
        public struct Snippet: Codable, Equatable {
            public var publishedAt: Date?
            public var channelId: String?
            public var title: String?
            public var description: String?
            public var thumbnails: YTO.Thumbnails?
            public var channelTitle: String?
            public var tags: [String]?
            public var categoryId: YTO.VideoCategoryID?
            public var liveBroadcastContent: String?
            public var defaultLanguage: String?
            public var localized: YTO.Localization?
            public var defaultAudioLanguage: String?
            
            public init(publishedAt: Date? = nil, channelId: String? = nil, title: String? = nil, description: String? = nil, thumbnails: YTO.Thumbnails? = nil, channelTitle: String? = nil, tags: [String]? = nil, categoryId: YTO.VideoCategoryID? = nil, liveBroadcastContent: String? = nil, defaultLanguage: String? = nil, localized: YTO.Localization? = nil, defaultAudioLanguage: String? = nil) {
                self.publishedAt = publishedAt
                self.channelId = channelId
                self.title = title
                self.description = description
                self.thumbnails = thumbnails
                self.channelTitle = channelTitle
                self.tags = tags
                self.categoryId = categoryId
                self.liveBroadcastContent = liveBroadcastContent
                self.defaultLanguage = defaultLanguage
                self.localized = localized
                self.defaultAudioLanguage = defaultAudioLanguage
            }
        }
        
        public struct ContentDetails: Codable, Equatable {
            public var duration: ISO8601Duration?
            public var dimension: String?
            public var definition: Definition?
            public var caption: String?
            public var licensedContent: Bool?
            public var regionRestriction: RegionRestriction?
            public var contentRating: ContentRating?
            public var projection: Projection?
            public var hasCustomThumbnail: Bool?
            
            public init(
                duration: ISO8601Duration? = nil,
                dimension: String? = nil,
                definition: Definition? = nil,
                caption: String? = nil,
                licensedContent: Bool? = nil,
                regionRestriction: RegionRestriction? = nil,
                contentRating: ContentRating? = nil,
                projection: Projection? = nil,
                hasCustomThumbnail: Bool? = nil
            ) {
                self.duration = duration
                self.dimension = dimension
                self.definition = definition
                self.caption = caption
                self.licensedContent = licensedContent
                self.regionRestriction = regionRestriction
                self.contentRating = contentRating
                self.projection = projection
                self.hasCustomThumbnail = hasCustomThumbnail
            }
            
            public struct RegionRestriction: Codable, Equatable {
                public var allowed: [String]?
                public var blocked: [String]?
                
                public init(allowed: [String]? = nil, blocked: [String]? = nil) {
                    self.allowed = allowed
                    self.blocked = blocked
                }
            }
            
            public struct Definition: Hashable, Codable {
                public static let sd = Self("sd")
                public static let hd = Self("hd")
                public var value: String
                
                public init(_ value: String) { self.value = value }
                public init(from decoder: any Decoder) throws { self = try Self.init(String(from: decoder)) }
                public func encode(to encoder: any Encoder) throws { try value.encode(to: encoder) }
            }
            
            public struct Projection: Hashable, Codable {
                public static let sphere = Self("360")
                public static let rectangular = Self("rectangular")
                public var value: String
                
                public init(_ value: String) { self.value = value }
                public init(from decoder: any Decoder) throws { self = try Self.init(String(from: decoder)) }
                public func encode(to encoder: any Encoder) throws { try value.encode(to: encoder) }
            }
            
            public struct ContentRating: Codable, ExpressibleByDictionaryLiteral, Equatable {
                
                private var ratings: [Key: String]
                
                public init(from decoder: any Decoder) throws {
                    let container = try decoder.container(keyedBy: Key.self)
                    ratings = Dictionary(minimumCapacity: container.allKeys.count)
                    for key in container.allKeys {
                        ratings[key] = try container.decode(String.self, forKey: key)
                    }
                }
                
                public func encode(to encoder: any Encoder) throws {
                    var container = encoder.container(keyedBy: Key.self)
                    for (key, value) in ratings {
                        try container.encode(value, forKey: key)
                    }
                }
                
                public init(dictionaryLiteral elements: (Key, String)...) {
                    ratings = Dictionary(elements) { _, p in p }
                }
                
                public struct Key: Codable, Hashable, CodingKey, CustomStringConvertible {
                    
                    public var value: String
                    public var stringValue: String { value + "Rating" }
                    public var intValue: Int? { nil }
                    public var description: String { stringValue }
                    
                    public init(stringValue rawValue: String) {
                        var string = rawValue
                        if string.hasSuffix("Rating") {
                            string.removeLast(6)
                        }
                        self.init(string)
                    }
                    
                    public init?(intValue: Int) {
                        return nil
                    }
                    
                    public init(_ value: String) {
                        self.value = value
                    }
                    
                    public init(from decoder: any Decoder) throws {
                        try self.init(String(from: decoder))
                    }
                    
                    public func encode(to encoder: any Encoder) throws {
                        try value.encode(to: encoder)
                    }
                    
                    public static let acb = Self("acb")
                    public static let agcom = Self("agcom")
                    public static let anatel = Self("anatel")
                    public static let bbfc = Self("bbfc")
                    public static let bfvc = Self("bfvc")
                    public static let bmukk = Self("bmukk")
                    public static let catv = Self("catv")
                    public static let catvfr = Self("catvfr")
                    public static let cbfc = Self("cbfc")
                    public static let ccc = Self("ccc")
                    public static let cce = Self("cce")
                    public static let chfilm = Self("chfilm")
                    public static let chvrs = Self("chvrs")
                    public static let cicf = Self("cicf")
                    public static let cna = Self("cna")
                    public static let cnc = Self("cnc")
                    public static let csa = Self("csa")
                    public static let cscf = Self("cscf")
                    public static let czfilm = Self("czfilm")
                    public static let djctq = Self("djctq")
                    public static let ecbmct = Self("ecbmct")
                    public static let eefilm = Self("eefilm")
                    public static let egfilm = Self("egfilm")
                    public static let eirin = Self("eirin")
                    public static let fcbm = Self("fcbm")
                    public static let fco = Self("fco")
                    public static let fmoc = Self("fmoc")
                    public static let fpb = Self("fpb")
                    public static let fsk = Self("fsk")
                    public static let grfilm = Self("grfilm")
                    public static let icaa = Self("icaa")
                    public static let ifco = Self("ifco")
                    public static let ilfilm = Self("ilfilm")
                    public static let incaa = Self("incaa")
                    public static let kfcb = Self("kfcb")
                    public static let kijkwijzer = Self("kijkwijzer")
                    public static let kmrb = Self("kmrb")
                    public static let lsf = Self("lsf")
                    public static let mccaa = Self("mccaa")
                    public static let mccyp = Self("mccyp")
                    public static let mcst = Self("mcst")
                    public static let mda = Self("mda")
                    public static let medietilsynet = Self("medietilsynet")
                    public static let meku = Self("meku")
                    public static let mibac = Self("mibac")
                    public static let moc = Self("moc")
                    public static let moctw = Self("moctw")
                    public static let mpaa = Self("mpaa")
                    public static let mpaat = Self("mpaat")
                    public static let mtrcb = Self("mtrcb")
                    public static let nbc = Self("nbc")
                    public static let nbcpl = Self("nbcpl")
                    public static let nfrc = Self("nfrc")
                    public static let nfvcb = Self("nfvcb")
                    public static let nkclv = Self("nkclv")
                    public static let oflc = Self("oflc")
                    public static let pefilm = Self("pefilm")
                    public static let rcnof = Self("rcnof")
                    public static let resorteviolencia = Self("resorteviolencia")
                    public static let rtc = Self("rtc")
                    public static let rte = Self("rte")
                    public static let russia = Self("russia")
                    public static let skfilm = Self("skfilm")
                    public static let smais = Self("smais")
                    public static let smsa = Self("smsa")
                    public static let tvpg = Self("tvpg")
                    public static let yt = Self("yt")
                }
            }
        }
        
        public struct Status: Codable, Equatable {
            public var uploadStatus: UploadStatus?
            public var failureReason: YTO.FailureReason?
            public var rejectionReason: YTO.RejectionReason?
            public var privacyStatus: YTO.PrivacyStatus?
            public var publishAt: Date?
            public var license: YTO.License?
            public var embeddable: Bool?
            public var publicStatsViewable: Bool?
            public var madeForKids: Bool?
            public var selfDeclaredMadeForKids: Bool?
            
            public init(
                uploadStatus: YTO.UploadStatus? = nil,
                failureReason: YTO.FailureReason? = nil,
                rejectionReason: YTO.RejectionReason? = nil,
                privacyStatus: YTO.PrivacyStatus? = nil,
                publishAt: Date? = nil,
                license: YTO.License? = nil,
                embeddable: Bool? = nil,
                publicStatsViewable: Bool? = nil,
                madeForKids: Bool? = nil,
                selfDeclaredMadeForKids: Bool? = nil
            ) {
                self.uploadStatus = uploadStatus
                self.failureReason = failureReason
                self.rejectionReason = rejectionReason
                self.privacyStatus = privacyStatus
                self.publishAt = publishAt
                self.license = license
                self.embeddable = embeddable
                self.publicStatsViewable = publicStatsViewable
                self.madeForKids = madeForKids
                self.selfDeclaredMadeForKids = selfDeclaredMadeForKids
            }
        }
        
        public struct Statistics: Codable, Equatable {
            public var viewCount: String?
            public var likeCount: String?
            public var dislikeCount: String?
            public var favoriteCount: String?
            public var commentCount: String?
            
            public init(viewCount: String? = nil, likeCount: String? = nil, dislikeCount: String? = nil, favoriteCount: String? = nil, commentCount: String? = nil) {
                self.viewCount = viewCount
                self.likeCount = likeCount
                self.dislikeCount = dislikeCount
                self.favoriteCount = favoriteCount
                self.commentCount = commentCount
            }
        }

        public struct TopicDetails: Codable, Equatable {
            public var topicIds: [String]?
            public var relevantTopicIds: [String]?
            public var topicCategories: [String]?
            
            public init(topicIds: [String]? = nil, relevantTopicIds: [String]? = nil, topicCategories: [String]? = nil) {
                self.topicIds = topicIds
                self.relevantTopicIds = relevantTopicIds
                self.topicCategories = topicCategories
            }
        }
        
        public struct RecordingDetails: Codable, Equatable {
            public var recordingDate: Date?
            
            public init(recordingDate: Date? = nil) {
                self.recordingDate = recordingDate
            }
        }
        
        public struct FileDetails: Codable, Equatable {
            public var fileName: String?
            public var fileSize: Int?
            public var fileType: YTO.FileType?
            public var container: String?
            public var videoStreams: [VideoStream]?
            public var audioStreams: [AudioStream]?
            public var durationMs: Int?
            public var bitrateBps: Int?
            public var creationTime: String?
            
            public init(fileName: String? = nil, fileSize: Int? = nil, fileType: YTO.FileType? = nil, container: String? = nil, videoStreams: [VideoStream]? = nil, audioStreams: [AudioStream]? = nil, durationMs: Int? = nil, bitrateBps: Int? = nil, creationTime: String? = nil) {
                self.fileName = fileName
                self.fileSize = fileSize
                self.fileType = fileType
                self.container = container
                self.videoStreams = videoStreams
                self.audioStreams = audioStreams
                self.durationMs = durationMs
                self.bitrateBps = bitrateBps
                self.creationTime = creationTime
            }
            
            public struct VideoStream: Codable, Equatable {
                public var widthPixels: Int?
                public var heightPixels: Int?
                public var frameRateFps: Double?
                public var aspectRatio: Double?
                public var codec: String?
                public var bitrateBps: Int?
                public var rotation: String?
                public var vendor: String?
                
                public init(widthPixels: Int? = nil, heightPixels: Int? = nil, frameRateFps: Double? = nil, aspectRatio: Double? = nil, codec: String? = nil, bitrateBps: Int? = nil, rotation: String? = nil, vendor: String? = nil) {
                    self.widthPixels = widthPixels
                    self.heightPixels = heightPixels
                    self.frameRateFps = frameRateFps
                    self.aspectRatio = aspectRatio
                    self.codec = codec
                    self.bitrateBps = bitrateBps
                    self.rotation = rotation
                    self.vendor = vendor
                }
            }
            
            public struct AudioStream: Codable, Equatable {
                public var channelCount: Int?
                public var codec: String?
                public var bitrateBps: Int?
                public var vendor: String?
                
                public init(channelCount: Int? = nil, codec: String? = nil, bitrateBps: Int? = nil, vendor: String? = nil) {
                    self.channelCount = channelCount
                    self.codec = codec
                    self.bitrateBps = bitrateBps
                    self.vendor = vendor
                }
            }
        }
        
        public struct ProcessingDetails: Codable, Equatable {
            public var processingStatus: String?
            public var processingProgress: ProcessingProgress?
            public var processingFailureReason: String?
            public var fileDetailsAvailability: String?
            public var processingIssuesAvailability: String?
            public var tagSuggestionsAvailability: String?
            public var editorSuggestionsAvailability: String?
            public var thumbnailsAvailability: String?
            
            public init(processingStatus: String? = nil, processingProgress: ProcessingProgress? = nil, processingFailureReason: String? = nil, fileDetailsAvailability: String? = nil, processingIssuesAvailability: String? = nil, tagSuggestionsAvailability: String? = nil, editorSuggestionsAvailability: String? = nil, thumbnailsAvailability: String? = nil) {
                self.processingStatus = processingStatus
                self.processingProgress = processingProgress
                self.processingFailureReason = processingFailureReason
                self.fileDetailsAvailability = fileDetailsAvailability
                self.processingIssuesAvailability = processingIssuesAvailability
                self.tagSuggestionsAvailability = tagSuggestionsAvailability
                self.editorSuggestionsAvailability = editorSuggestionsAvailability
                self.thumbnailsAvailability = thumbnailsAvailability
            }
            
            public struct ProcessingProgress: Codable, Equatable {
                public var partsTotal: Int?
                public var partsProcessed: Int?
                public var timeLeftMs: Int?
                
                public init(partsTotal: Int? = nil, partsProcessed: Int? = nil, timeLeftMs: Int? = nil) {
                    self.partsTotal = partsTotal
                    self.partsProcessed = partsProcessed
                    self.timeLeftMs = timeLeftMs
                }
            }
        }
        
        public struct Suggestions: Codable, Equatable {
            public var processingErrors: [String]?
            public var processingWarnings: [String]?
            public var processingHints: [String]?
            public var tagSuggestions: [TagSuggestion]?
            public var editorSuggestions: [String]?
            
            public init(processingErrors: [String]? = nil, processingWarnings: [String]? = nil, processingHints: [String]? = nil, tagSuggestions: [TagSuggestion]? = nil, editorSuggestions: [String]? = nil) {
                self.processingErrors = processingErrors
                self.processingWarnings = processingWarnings
                self.processingHints = processingHints
                self.tagSuggestions = tagSuggestions
                self.editorSuggestions = editorSuggestions
            }
            
            public struct TagSuggestion: Codable, Equatable {
                public var tag: String?
                public var categoryRestricts: [String]?
                
                public init(tag: String? = nil, categoryRestricts: [String]? = nil) {
                    self.tag = tag
                    self.categoryRestricts = categoryRestricts
                }
            }
        }
        
        public struct LiveStreamingDetails: Codable, Equatable {
            public var actualStartTime: Date?
            public var actualEndTime: Date?
            public var scheduledStartTime: Date?
            public var scheduledEndTime: Date?
            public var concurrentViewers: Int?
            public var activeLiveChatId: String?
            
            public init(actualStartTime: Date? = nil, actualEndTime: Date? = nil, scheduledStartTime: Date? = nil, scheduledEndTime: Date? = nil, concurrentViewers: Int? = nil, activeLiveChatId: String? = nil) {
                self.actualStartTime = actualStartTime
                self.actualEndTime = actualEndTime
                self.scheduledStartTime = scheduledStartTime
                self.scheduledEndTime = scheduledEndTime
                self.concurrentViewers = concurrentViewers
                self.activeLiveChatId = activeLiveChatId
            }
        }
    }
}

extension YouTube.Objects.Video {

    public var link: URL? {
        id.flatMap { URL(string: "https://www.youtube.com/watch?v=\($0)") }
    }
}
