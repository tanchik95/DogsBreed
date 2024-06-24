//
//  ProfileView.swift
//  DogsBreed
//
//  Created by Татьяна Исаева on 23.06.2024.
//

import UIKit

final class ProfileView: UIView {
	struct ViewMetrics {

		let avatarImageViewSize = CGSize(width: 192.0, height: 192.0)
		var avatarCR: CGFloat { avatarImageViewSize.height / 2 }
		let spinnerColor: UIColor = .black
	}

	// MARK: Private Properties

	private let viewMetrics = ViewMetrics()
	private var model: DogBreedsDetailsViewModel?

	// MARK: Public Properties
	var nickname: String = ""

	// MARK: Output
	var onTapSaveButton: (() -> Void)?
	var onTapAvatar: (() -> Void)?
	var onFieldChanged: (() -> Void)?

	// MARK: - View Properties

	private lazy var spinner: UIActivityIndicatorView = {
		let spinner = UIActivityIndicatorView(style: .medium)
		spinner.startAnimating()
		spinner.color = viewMetrics.spinnerColor
		spinner.hidesWhenStopped = true
		return spinner
	}()

	fileprivate(set) lazy var avatarViewEditor: UIImageView = {
		let avatarView = UIImageView()
		avatarView.contentMode = .scaleAspectFill
		avatarView.layer.cornerRadius = viewMetrics.avatarCR
		avatarView.layer.masksToBounds = true
		avatarView.isUserInteractionEnabled = true

		let gesureRec = UITapGestureRecognizer(
			target: self,
			action: #selector(avatarEditor))
		avatarView.addGestureRecognizer(gesureRec)

		return avatarView
	}()

	fileprivate(set) lazy var nicknameTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = "Никнейм"
		textField.textAlignment = .center
		textField.text = UserDefaults.standard.getNicknameName()
		textField.backgroundColor = .white
		textField.textColor = .black
		textField.layer.borderWidth = Sizes.borderWidth
		textField.layer.cornerRadius = Sizes.cornerRadius
		textField.layer.borderColor = UIColor.lightGray.cgColor
		textField.addTarget(self, action: #selector(didEditTextField), for: .allEvents)
		textField.leftViewMode = .always
		textField.text = UserDefaults.standard.getNicknameName()

		return textField
	}()

	 lazy var saveButton: UIButton = {
		let button = UIButton()
		button.setTitle("Сохранить", for: .normal)
		button.addTarget(self, action: #selector(saveProfile), for: .touchUpInside)
		 button.configuration?.cornerStyle = .medium
		 button.backgroundColor = UIColor.orange
		 button.isUserInteractionEnabled = true
		return button
	}()


	// MARK: - Init

	init(frame: CGRect, viewMetrics: ViewMetrics = .init()) {
		super.init(frame: frame)

		addSubviews(avatarViewEditor)
		avatarViewEditor.addSubview(spinner)
		addSubviews(nicknameTextField)
		addSubviews(saveButton)

		configureLayout()

	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	// MARK: Private Method

	private func configureLayout() {
		spinner.snp.makeConstraints { make in
			make.center.equalTo(avatarViewEditor.snp.center)
		}

		avatarViewEditor.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalToSuperview().offset(96)
			make.size.equalTo(viewMetrics.avatarImageViewSize)
		}

		nicknameTextField.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalTo(avatarViewEditor.snp.bottom).offset(16)
			make.left.equalToSuperview().offset(16)
			make.right.equalToSuperview().offset(-16)
			make.size.height.equalTo(48)
		}

		saveButton.snp.makeConstraints { make in
			make.centerX.equalToSuperview()
			make.top.equalTo(nicknameTextField.snp.bottom).offset(16)
			make.left.equalToSuperview().offset(24)
			make.right.equalToSuperview().offset(-24)
			make.size.height.equalTo(48)
		}
	}

	@objc
	private func avatarEditor(_ sender: UITextField) {
		self.onTapAvatar?()
	}

	@objc
	private func didEditTextField(_ sender: UITextField) {
		saveButton.backgroundColor = .orange
		saveButton.isUserInteractionEnabled = true
	}

	@objc
	private func saveProfile(_ sender: UITextField) {
		nickname = nicknameTextField.text ?? ""
		UserDefaults.standard.setNickname(nickname: nickname)
		saveButton.backgroundColor = .gray
		saveButton.isUserInteractionEnabled = false
		self.onTapSaveButton?()
	}

	func showLoading() {
		spinner.startAnimating()
	}

	func showView() {
		spinner.stopAnimating()
	}
}
