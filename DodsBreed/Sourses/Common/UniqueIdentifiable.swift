//
//  UniqueIdentifiable.swift
//
//  Created by Татьяна Исаева on 13.10.2022.
//

import Foundation

typealias UniqueIdentifier = Int

protocol UniqueIdentifiable {
	var uid: UniqueIdentifier { get }
}

