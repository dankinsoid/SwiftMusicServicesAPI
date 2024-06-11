import Foundation
import SwiftMusicServicesApi

extension Amazon.Music.DeviceAPI {
    
    public func browse() async throws -> Amazon.Objects.Document {
        try await client.get()
    }
}

extension Amazon.Objects {

    // Navigation Node Summary
    public struct NavigationNodeSummary: Codable, Equatable {
        public let title: String
        public let description: String
        
        public init(title: String, description: String) {
            self.title = title
            self.description = description
        }
    }
    
    // Item Description
    public struct ItemDescription: Codable, Equatable {
        public let itemLabel: String
        public let navigationNodeSummary: String
        
        public init(itemLabel: String, navigationNodeSummary: String) {
            self.itemLabel = itemLabel
            self.navigationNodeSummary = navigationNodeSummary
        }
    }

    // Navigation Node Description
    public struct NavigationNodeDescription: Codable, Equatable {
        public let summary: String
        public let items: [String]
        
        public init(summary: String, items: [String]) {
            self.summary = summary
            self.items = items
        }
    }

    // Document
    public struct Document: Codable, Equatable {
        public let result: String
        public let navigationNodeDescriptions: [String: NavigationNodeDescription]
        public let navigationNodeSummaries: [String: NavigationNodeSummary]
        public let itemDescriptions: [String: ItemDescription]
        
        public init(result: String, navigationNodeDescriptions: [String: NavigationNodeDescription], navigationNodeSummaries: [String: NavigationNodeSummary], itemDescriptions: [String: ItemDescription]) {
            self.result = result
            self.navigationNodeDescriptions = navigationNodeDescriptions
            self.navigationNodeSummaries = navigationNodeSummaries
            self.itemDescriptions = itemDescriptions
        }
    }
}
