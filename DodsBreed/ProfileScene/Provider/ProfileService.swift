//
//  ProfileService.swift
//  DogsBreed
//
//  Created by Татьяна Исаева on 23.06.2024.
//

import Foundation

protocol ProfileServiceProtocol {
	func fetchItems(completion: @escaping (ProfileModel?, Error?) -> Void)
}

final class ProfileService: ProfileServiceProtocol {
	let decoder: JSONDecoder
	let apiUrl = "https://dog.ceo/api/breeds/image/random"

	// MARK: - Init

	init(decoder: JSONDecoder = JSONDecoder()) {
		self.decoder = decoder
	}

	// MARK: - Network Request

	private func fetchDataFromAPI(completion: @escaping (ProfileModel?, Error?) -> Void) {
		guard let url = URL(string: apiUrl) else {
			completion(nil, Profile.ProfileScreen.Response.Error.fetchError)
			return
		}

		var urlRequest = URLRequest(url: url)
		urlRequest.httpMethod = "GET"

		let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
			if let error = error {
				completion(nil, error)
				return
			}

			guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
				completion(nil, Profile.ProfileScreen.Response.Error.parsingError)
				return
			}

			guard let data = data else {
				completion(nil, Profile.ProfileScreen.Response.Error.someError)
				return
			}

			completion(self.parseSuccessData(data: data), nil)
		}

		task.resume()
	}

	private func parseSuccessData(data: Data) -> ProfileModel? {
		do {
			let models = try decoder.decode(ProfileModel.self, from: data)
			return models
		} catch {
			return nil
		}
	}

	// MARK: ProfileServiceProtocol
	func fetchItems(completion: @escaping (ProfileModel?, Error?) -> Void) {
		fetchDataFromAPI(completion: completion)
	}
}
