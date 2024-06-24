//
//  UIViewController+Extension.swift
//  DodsBreed
//
//  Created by Татьяна Исаева on 23.06.2024.
//


import UIKit
extension UIViewController {

	// MARK: - Alert
	func showAlert(title: String? = nil, message: String? = nil, actions: [UIAlertAction], style: UIAlertController.Style = .alert, tintColor: UIColor? = nil) {
		let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
		for action in actions {
			alertController.addAction(action)
		}
		if let tintColor = tintColor {
			alertController.view.tintColor = tintColor
		}
		present(alertController, animated: true)
	}

	// MARK: - Navigation Bar
	func setNavigationBackButton() {
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
		navigationController?.navigationBar.backIndicatorImage = UIImage(named: "arrowLeft")
		navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "arrowLeft")
	}
}
