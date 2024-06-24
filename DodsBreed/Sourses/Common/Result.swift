//
//  Result.swift
//
//  Created by Татьяна Исаева on 13.10.2022.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
