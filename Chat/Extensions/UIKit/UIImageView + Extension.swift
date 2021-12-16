//
//  UIImageView + Extension.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 09.12.2021.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage?,
                     contentMode: UIView.ContentMode) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
}
