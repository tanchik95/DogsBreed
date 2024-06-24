//
//  ProfileDataStore.swift
//  DogsBreed
//
//  Created by Татьяна Исаева on 23.06.2024.
//

import Foundation

protocol ProfileDataStoreProtocol: AnyObject {
	var model: ProfileModel? { get set }
}

final class ProfileDataStore: ProfileDataStoreProtocol {
	static let shared = ProfileDataStore()
	var model: ProfileModel?
}
