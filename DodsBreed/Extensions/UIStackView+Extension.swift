//
//  UIStackView+Extension.swift
//
//  Created by Татьяна Исаева on 31.03.2023.
//

import UIKit

extension UIStackView {
    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach(self.addArrangedSubview)
    }
}
