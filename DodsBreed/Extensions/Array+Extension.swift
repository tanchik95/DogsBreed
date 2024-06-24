//
//  Array+Extension.swift
//
//  Created by Татьяна Исаева on 31.03.2023.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
}
