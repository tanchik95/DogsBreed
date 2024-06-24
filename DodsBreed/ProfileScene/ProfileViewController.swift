//
//  ProfileViewController.swift
//  DogsBreed
//
//  Created by Татьяна Исаева on 23.06.2024.
//

import UIKit
import Photos

protocol ProfileDisplayLogic: AnyObject {
	func showAvatarURL(data: Data?)
}

final class ProfileViewController: UIViewController, ProfileDisplayLogic {
	let interactor: ProfileBusinessLogic

	// MARK: Private Properties
	private lazy var dogProfiveView = self.view as? ProfileView

	// MARK: - Init

	init(interactor: ProfileBusinessLogic) {
		self.interactor = interactor
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		let view = ProfileView(frame: .zero)

		view.onTapAvatar = { [weak self] in
			guard let self = self else { return }

			self.avatarOptionsAlert()
		}

		view.onTapSaveButton  = { [weak self] in
			guard let self = self else { return }

			self.saveAvatar()
		}

		self.view = view
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .white
		navigationItem.largeTitleDisplayMode = .never

		dogProfiveView?.showLoading()

		let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
		let filePath = documentsPath.appendingPathComponent("savedImage.jpg")

		if let imageData = try? Data(contentsOf: filePath) {
			if let savedImage = UIImage(data: imageData) {
				dogProfiveView?.avatarViewEditor.image = savedImage
				dogProfiveView?.showView()
			}
		} else {
			let request = Profile.ProfileScreen.Request()
			interactor.fetchRandomImage(request: request)
		}
	}

	// MARK: - Private Methods
	private func saveAvatar() {
		let imageToSave = dogProfiveView?.avatarViewEditor.image
		guard let imageData = imageToSave?.jpegData(compressionQuality: 0.8) else { return }
		let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
		let fileName = "savedImage.jpg"
		let filePath = documentsPath.appendingPathComponent(fileName)
		try? imageData.write(to: filePath)
	}

	private func avatarOptionsAlert() {
		let makePhoto = UIAlertAction(
			title: "Сделать фото",
			style: .default)
		{
			[weak self] _ in
			guard let self = self else { return }
			self.authorizeToCamera()
		}

		let choosePhoto = UIAlertAction(
			title: "Выбрать из галереии",
			style: .default)
		{
			[weak self] _  in
			guard let self = self else { return }
			self.authorizeToPhotoLibrary()
		}


		let cancel = UIAlertAction(
			title: "Отмена",
			style: .cancel)

		self.showAlert(
			actions: [
				makePhoto,
				choosePhoto,
				cancel,
			],
			style: .actionSheet,
			tintColor: UIColor.label)
	}

	private func presentPickerAlert(
		title: String?,
		message: String?)
	{
		let goToSettings = UIAlertAction(
			title: "Настройки",
			style: .default)
		{
			_ in
			guard
				let url = URL(string: UIApplication.openSettingsURLString),
				UIApplication.shared.canOpenURL(url)
			else { return }
			UIApplication.shared.open(url)
		}
		let cancel = UIAlertAction(
			title: "Отмена",
			style: .cancel)
		let actions = [
			goToSettings,
			cancel,
		]

		showAlert(
			title: "Приложение не может использовать фотокамеру",
			message: "Чтобы включить доступ к фотокамере , перейдите в Настройки → Carbery → Камера",
			actions: actions,
			style: .actionSheet,
			tintColor: UIColor.label)
	}

	private func authorizeToCamera() {
		guard AVCaptureDevice.authorizationStatus(for: .video) != .authorized else {
			presentCameraPickerController()
			return
		}

		AVCaptureDevice.requestAccess(for: .video) { [weak self] response in
			guard let self = self else { return }
			if response {
				DispatchQueue.main.async { [weak self] in
					guard let self = self else { return }
					self.presentCameraPickerController()
				}
			} else {
				DispatchQueue.main.async {
					self.presentPickerAlert(
						title: "Приложение не может использовать фотокамеру",
						message: "Чтобы включить доступ к фотокамере , перейдите в Настройки → Carbery → Камера")
				}
			}
		}
	}

	private func presentCameraPickerController() {
		DispatchQueue.main.async {[weak self] in
			let picker: UIImagePickerController = {
				let picker = UIImagePickerController()
				picker.delegate = self
				picker.sourceType = .camera
				picker.cameraCaptureMode = .photo
				picker.cameraDevice = .front
				picker.allowsEditing = true
				return picker
			}()
			self?.present(picker, animated: true)
		}
	}

	private func authorizeToPhotoLibrary() {
		guard PHPhotoLibrary.authorizationStatus() != .authorized else {
			presentLibraryController()
			return
		}

		PHPhotoLibrary.requestAuthorization { [weak self] (status) in
			guard let self = self else { return }
			switch status {
			case .authorized:
				self.presentLibraryController()
			default:
				DispatchQueue.main.async {
					self.presentPickerAlert(
						title: "Приложение не может использовать фото библиотеку",
						message: "Чтобы включить доступ к фото библиотеке, перейдите в Настройки → Carbery → Фото")
				}
			}
		}
	}

	private func presentLibraryController() {
		DispatchQueue.main.async {[weak self] in
			let picker: UIImagePickerController = {
				let picker = UIImagePickerController()
				picker.delegate = self
				picker.sourceType = .photoLibrary
				picker.allowsEditing = true
				return picker
			}()
			self?.present(picker, animated: true)
		}
	}

	// MARK: - Public Methods

	// При каждом входе в приложение генерируется случаный аватар по url, до момента нажатия кнопки "Сохранить"
	func showAvatarURL(data: Data?) {
		DispatchQueue.main.async {[weak self] in
			self?.dogProfiveView?.avatarViewEditor.image = UIImage(data: data ?? Data())
			self?.dogProfiveView?.showView()
		}
	}
}

// MARK: - Profile Delegate

extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
	func imagePickerController(
		_ picker: UIImagePickerController,
		didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any])
	{
		guard
			let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage,
			let compressedImage = image.compressTo(15)

		else { return }

		dogProfiveView?.avatarViewEditor.image = compressedImage
		dismiss(animated: true)
	}

	func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true)
	}
}

