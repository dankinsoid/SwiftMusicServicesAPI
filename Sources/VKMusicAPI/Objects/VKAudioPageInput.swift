//
// Created by Данил Войдилов on 08.04.2022.
//

import Foundation

public struct VKAudioPageInput: Codable {
	public var section: Section?
	public var block: Block?
	public var z: String?

	public init(section: Section? = nil, block: Block? = nil, z: String? = nil) {
		self.section = section
		self.block = block
		self.z = z
	}

	public enum Section: String, Codable {
		case my, all
	}

	public enum Block: String, Codable {
		case my_playlists
	}
}