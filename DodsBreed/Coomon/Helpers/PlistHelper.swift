//
//  PlistHelper.swift
//  DogsBreed
//
//  Created by Татьяна Исаева on 23.06.2024.
//

import Foundation

final class PlistHelper {
	func infoForKey(_ key: String) -> String? { Bundle.main.infoDictionary?[key] as? String }
}
