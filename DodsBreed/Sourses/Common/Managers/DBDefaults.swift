//
//  DBDefaults.swift
//  DogBreeds
//
//  Created by Татьяна Исаева on 22.06.2024.
//

import Foundation

extension UserDefaults {
	func getFeaturedBreeds() -> [UniqueIdentifier]? {
		return array(forKey: VTDefaultsKeys.isFavorites.rawValue) as? [UniqueIdentifier]
	}

	func remove(featuredBreed: UniqueIdentifier) {
		var array = getFeaturedBreeds() ?? []
		if array.contains(featuredBreed), let index = array.firstIndex(where: { $0 == featuredBreed }) {
			array.remove(at: index)
			set(array, forKey: VTDefaultsKeys.isFavorites.rawValue)
		}
	}

	func add(featuredBreed: UniqueIdentifier) {
		var array = getFeaturedBreeds() ?? []
		array.append(featuredBreed)
		set(array, forKey: VTDefaultsKeys.isFavorites.rawValue)
	}

	func setNickname(nickname: String?) {
		set(nickname, forKey: VTDefaultsKeys.nicknameProfile.rawValue)
	}

	func getNicknameName() -> String? {
		return string(forKey: VTDefaultsKeys.nicknameProfile.rawValue)
	}
}
