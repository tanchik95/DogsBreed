//
//  ProfileModel.swift
//  DogsBreed
//
//  Created by Татьяна Исаева on 23.06.2024.
//

import Foundation

struct ProfileModel: Decodable {
	let message: String
	let status: String

	enum CodingKeys: String, CodingKey {
		case message
		case status
	}
}

