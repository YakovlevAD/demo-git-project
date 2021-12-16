//
//  StackView + Extension.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 09.12.2021.
//

import UIKit

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing =  spacing
    }
}
