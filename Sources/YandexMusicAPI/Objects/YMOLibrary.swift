//
//  YMOLibrary.swift
//  MusicImport
//
//  Created by Данил Войдилов on 29.11.2020.
//  Copyright © 2020 Данил Войдилов. All rights reserved.
//

import Foundation

extension YMO {
	
	// MARK: - Result
 	public struct LibraryContainer: Codable {
		public let library: Library
 	}
	
	// MARK: - Library
	public struct Library: Codable {
		public let uid: Int
		public let revision: Int?
		public let tracks: [TrackShort]?
 	}
}
