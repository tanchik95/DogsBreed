//
//  ProfilePresenter.swift
//  DogsBreed
//
//  Created by Татьяна Исаева on 23.06.2024.
//

import Foundation

protocol ProfilePresentationLogic {
	func presentItem(response: Profile.ProfileScreen.Response)
}

final class ProfilePresenter {
	weak var viewController: ProfileDisplayLogic?
	let errorMessage = "Error loading data"
}

// MARK: - Presentation Logic
extension ProfilePresenter: ProfilePresentationLogic {
	func presentItem(response: Profile.ProfileScreen.Response) {
		switch response.result {
		case let .success(result):
			let profile: ProfileViewModel = .init(
				message: result.message,
				status: result.status)

			let stirng = profile.message
			if let url = URL(string: stirng) {
				if let data = try? Data(contentsOf: url) {
					self.viewController?.showAvatarURL(data: data)
				}
			}
		case .failure:
			print(errorMessage)
		}
	}
}
