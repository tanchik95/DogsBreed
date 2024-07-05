//
//  OnboardingSlideView.swift
//  DodsBreed
//
//  Created by Татьяна Исаева on 04.07.2024.
//

import UIKit

// MARK: - ViewMetrics
extension OnboardingSlideView {
	struct ViewMetrics {
		let titleLabelColor = UIColor.label
		let titleLabelAlignment: NSTextAlignment = .center
		let titleLabelNOL = 0
		let titleLabelInsets = UIEdgeInsets(top: 0.0, left: 32.0, bottom: 0.0, right: 32.0)

		let descriptionLabelColor = UIColor.secondaryLabel
		let descriptionLabelAlignment: NSTextAlignment = .center
		let descriptionLabelNOL = 0
		let descriptionLabelInsets = UIEdgeInsets(top: 12.0, left: 32.0, bottom: 0.0, right: 32.0)
	}
}

// MARK: - View
final class OnboardingSlideView: UIView {

	// MARK: Private properties
	private let viewMetrics = ViewMetrics()
	private var titleText: String

	// MARK: View properties
	fileprivate(set) lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = titleText
		label.textColor = viewMetrics.titleLabelColor
		label.textAlignment = viewMetrics.titleLabelAlignment
		label.numberOfLines = viewMetrics.titleLabelNOL

		return label
	}()

	// MARK: InitV
	init(title: String) {
		self.titleText = title
		super.init(frame: .zero)
		
		addSubview(titleLabel)
		configureLayout()
	}

	// MARK: Private Method
	private func configureLayout() {
		titleLabel.snp.makeConstraints { (make) in
			make.top.equalToSuperview().offset(viewMetrics.titleLabelInsets.top)
			make.left.right.equalToSuperview().inset(viewMetrics.titleLabelInsets)
		}
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

