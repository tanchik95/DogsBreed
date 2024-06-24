//
//  UIImage+Extension.swift
//  DogsBreed
//
//  Created by Татьяна Исаева on 23.06.2024.
//

import UIKit

extension UIImage {

	// MARK: - Compression
	func compressTo(_ expectedSizeInMb: Int) -> UIImage? {
		let sizeInBytes = expectedSizeInMb * 1024 * 1024
		var needCompress: Bool = true
		var imgData: Data?
		var compressingValue: CGFloat = 1.0
		while (needCompress && compressingValue > 0.0) {
			if let data: Data = self.jpegData(compressionQuality: compressingValue) {
				if data.count < sizeInBytes {
					needCompress = false
					imgData = data
				} else {
					compressingValue -= 0.1
				}
			}
		}

		guard let data = imgData, data.count < sizeInBytes else { return nil }
		return UIImage(data: data)
	}
}
