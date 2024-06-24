//
//  DataManager.swift
//  DogBreeds
//
//  Created by Татьяна Аникина on 22.06.2024.
//

import Foundation

//class DataManager<T: Codable> {
//	var fileName: String
//	var fileExt: String
//
//	init(fileName: String, fileExt: String) {
//		self.fileName = fileName
//		self.fileExt = fileExt
//	}
//
//	func update(data: T) -> Bool {
//		if let file = Bundle.main.url(forResource: fileName, withExtension: fileExt) {
//			let encoder = JSONEncoder()
//			if let json = try? encoder.encode(data){
//				let jsonString = String(data: json, encoding: String.Encoding.utf8)
//
//			}
//		}
//		return false
//
//	}
//	func get(data: String) -> Bool { return false }
//	func delete(data: String) -> Bool { return false }
//}
