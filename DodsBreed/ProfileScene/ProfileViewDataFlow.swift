//
//  ProfileViewDataFlow.swift
//  DogsBreed
//
//  Created by Татьяна Исаева on 23.06.2024.
//


import Foundation

enum Profile {
	enum ProfileScreen {
		struct Request {}

		struct Response {
			var result: Result<ProfileModel>

			enum Error: Swift.Error, LocalizedError {
				case fetchError
				case parsingError
				case notFound
				case someError

				var errorDescription: String? {
					switch self {
					case .fetchError:
						return "Error loading data"
					case .parsingError:
						return "Data is invalid!"
					case .notFound:
						return "Nothing Found! Data is empty!"
					case .someError:
						return "Something went wrong..."
					}
				}
			}
		}
	}
}

