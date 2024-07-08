//
//  DogView.swift
//  DodsBreed
//
//  Created by Татьяна Аникина on 08.07.2024.
//

import Foundation
import UIKit

class DogView: UIView {

	override func draw(_ rect: CGRect) {
		let context = UIGraphicsGetCurrentContext()!

		// Draw the dog's head
		context.beginPath()
		context.addEllipse(in: CGRect(x: 50, y: 100, width: 100, height: 100))
		context.closePath()
		context.setFillColor(UIColor.brown.cgColor)
		context.fillPath()

		// Draw the ears
		context.beginPath()
		context.move(to: CGPoint(x: 50, y: 80))
		context.addLine(to: CGPoint(x: 70, y: 40))
		context.addLine(to: CGPoint(x: 90, y: 80))
		context.closePath()
		context.setFillColor(UIColor.brown.cgColor)
		context.fillPath()

		context.beginPath()
		context.move(to: CGPoint(x: 150, y: 80))
		context.addLine(to: CGPoint(x: 130, y: 40))
		context.addLine(to: CGPoint(x: 110, y: 80))
		context.closePath()
		context.setFillColor(UIColor.brown.cgColor)
		context.fillPath()

		// Draw the eyes
		context.beginPath()
		context.addArc(center: CGPoint(x: 75, y: 110), radius: 10, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
		context.setFillColor(UIColor.black.cgColor)
		context.fillPath()

		context.beginPath()
		context.addArc(center: CGPoint(x: 125, y: 110), radius: 10, startAngle: 0, endAngle: 2 * .pi, clockwise: true)
		context.setFillColor(UIColor.black.cgColor)
		context.fillPath()

		// Draw the nose
		context.beginPath()
		context.move(to: CGPoint(x: 100, y: 120))
		context.addLine(to: CGPoint(x: 90, y: 130))
		context.addLine(to: CGPoint(x: 110, y: 130))
		context.closePath()
		context.setFillColor(UIColor.black.cgColor)
		context.fillPath()

		// Draw the mouth
		context.beginPath()
		context.move(to: CGPoint(x: 80, y: 150))
		context.addQuadCurve(to: CGPoint(x: 120, y: 150), control: CGPoint(x: 100, y: 170))
		context.closePath()
		context.setFillColor(UIColor.black.cgColor)
		context.fillPath()

		UIGraphicsEndImageContext()

	}


	override init(frame: CGRect) {
		super.init(frame: frame)
	}


	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}






