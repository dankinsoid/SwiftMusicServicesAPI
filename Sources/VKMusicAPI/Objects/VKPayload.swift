//
//  File.swift
//  
//
//  Created by Данил Войдилов on 08.04.2022.
//

import Foundation
import VDCodable

public struct VKPayload: Codable {
	public var payload: JSON
	public var statsMeta: JSON
}
