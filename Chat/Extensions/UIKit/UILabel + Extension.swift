//
//  UILabel + Extension.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 09.12.2021.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont? = .avenir20()) {
        self.init()
        
        self.text = text
        self.font = font
    }
}
