//
//  File.swift
//  
//
//  Created by Данил Войдилов on 08.04.2022.
//

import Foundation

public struct VKPlaylist: Codable, Identifiable, Hashable {
	public let id: Int
	public var owner: Int
	public var name: String
	public var artist: String?
	public var imageURL: URL?
	public var tracks: [VKAudio]?
	public var hash: String
	public var editHash: String?
}
