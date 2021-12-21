//
//  UIVIew + Extension.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 21.12.2021.
//

import UIKit

extension UIView {
    
    func applyGradients(cornerRadius:CGFloat) {
        self.backgroundColor = nil
        self.layoutIfNeeded()
        let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1), endColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1))
        if let gradientLayer = gradientView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = self.bounds
            gradientLayer.cornerRadius = cornerRadius
            self.layer.insertSublayer(gradientLayer, at: 0)
        }
//        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIImageView {
    func setupColor(color: UIColor) {
        let teamplateimage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = teamplateimage
        self.tintColor = color
    }
}
