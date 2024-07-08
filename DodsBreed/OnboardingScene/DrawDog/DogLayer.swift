//
//  DogLayer.swift
//  DodsBreed
//
//  Created by Татьяна Аникина on 08.07.2024.
//

import UIKit

class DogLayer: CALayer {

	override init(frame: CGRect) {
		super.init(frame: frame)

		let context = UIGraphicsGetCurrentContext()!

		// ... (вставьте код рисования собаки)

		let image = UIGraphicsGetImageFromCurrentImageContext()!
		self.contents = image.cgImage
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

let dogLayer = DogLayer(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
view.layer.addSublayer(dogLayer)
