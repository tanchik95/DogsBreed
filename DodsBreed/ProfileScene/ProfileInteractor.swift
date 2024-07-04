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
		provider.getItem { [weak self] item, error in
			guard let self = self else { return }

			var result: Result<ProfileModel>

			if let error = error {
				result = .failure(ProfileProviderError.getItemsFailed(withError: error))
			} else if let item = item {
				result = .success(item)
			} else {
				result = .failure(Profile.ProfileScreen.Response.Error.someError)
			}

			self.presenter.presentItem(response: .init(result: result))
		}
	}
}
