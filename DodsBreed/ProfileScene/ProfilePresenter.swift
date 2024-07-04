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
			let urlString = result.message
				viewController?.showError(message: "Invalid image URL")
			if let url = URL(string: urlString) {
				do {
					let data = try Data(contentsOf: url)
					viewController?.showAvatarURL(data: data)
				} catch {
					viewController?.showError(message: "Failed to load avatar image: \(error.localizedDescription)")
				}
			} else {
				viewController?.showError(message: "Invalid image URL format")
			}

		case .failure:
			viewController?.showError(message: errorMessage)
		}
	}
}
