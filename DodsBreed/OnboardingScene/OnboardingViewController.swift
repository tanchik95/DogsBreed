//
//  OnboardingViewController.swift
//  DodsBreed
//
//  Created by Татьяна Исаева on 04.07.2024.
//

import UIKit


final class OnboardingViewController: UIViewController {

	// MARK: - Init
	init() {
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		let view = OnboardingView(frame: .zero)
		self.view = view
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
	}
}


