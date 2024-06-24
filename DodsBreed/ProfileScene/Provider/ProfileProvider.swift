//
//  ProfileProvider.swift
//  DogsBreed
//
//  Created by Татьяна Исаева on 23.06.2024.
//

import Foundation

protocol ProfileProviderProtocol {
	func getItem(completion: @escaping (ProfileModel?, ProfileProviderError?) -> Void)
}

enum ProfileProviderError: Error {
	case getItemsFailed(withError: Error)

	var associatedValue: Error {
		switch self {
		case .getItemsFailed(let withError):
			return withError
		}
	}
}

struct ProfileProvider {
	let dataStore: ProfileDataStoreProtocol
	let service: ProfileServiceProtocol

	// MARK: Init

	init(dataStore: ProfileDataStoreProtocol = ProfileDataStore.shared, service: ProfileServiceProtocol = ProfileService()) {
		self.dataStore = dataStore
		self.service = service
	}
}

// MARK: - ProfileProviderProtocol

extension ProfileProvider: ProfileProviderProtocol {
	func getItem(completion: @escaping (ProfileModel?, ProfileProviderError?) -> Void) {
		service.fetchItems { (model, error) in
			if let error = error {
				completion(nil, .getItemsFailed(withError: error))
			} else if let model = model {
				self.dataStore.model = model
				completion(self.dataStore.model, nil)
			}
		}
	}
}
