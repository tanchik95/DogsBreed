//
//  ProfileInteractor.swift
//  DodsBreed
//
//  Created by Татьяна Исаева on 23.06.2024.
//

import Foundation

protocol ProfileBusinessLogic {
	func fetchRandomImage(request: Profile.ProfileScreen.Request)
}

final class ProfileInteractor {
	let presenter: ProfilePresentationLogic
	let provider: ProfileProviderProtocol

	// MARK: - Init

	init(presenter: ProfilePresentationLogic, provider: ProfileProviderProtocol = ProfileProvider()) {
		self.presenter = presenter
		self.provider = provider
	}
}

// MARK: - Business Logic
extension ProfileInteractor: ProfileBusinessLogic {
	func fetchRandomImage(request: Profile.ProfileScreen.Request) {
		provider.getItem { (items, error) in
			let result: Result<ProfileModel>
			if let items = items {
				result = .success(items)
			} else if let error = error {
				result = .failure(error.associatedValue)
			} else {
				result = .failure(Profile.ProfileScreen.Response.Error.someError)
			}
			self.presenter.presentItem(response: .init(result: result))
		}
	}
}
