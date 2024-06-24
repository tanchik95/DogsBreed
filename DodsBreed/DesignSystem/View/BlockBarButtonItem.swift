
import UIKit

class BlockBarButtonItem: UIBarButtonItem {

	// MARK: Private Properties
	private var actionHandler: (() -> Void)?

	// MARK: Init
	convenience init(icon: UIImage, _ actionHandler: (() -> Void)?) {
		self.init(image: icon, style: .plain, target: nil, action: #selector(barButtonItemPressed))
		self.target = self
		self.actionHandler = actionHandler
	}

	// MARK: Private Methods
	@objc
	private func barButtonItemPressed(sender: UIBarButtonItem) {
		actionHandler?()
	}
}
