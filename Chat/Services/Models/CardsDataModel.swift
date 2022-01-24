//
//  CardsDataModel.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 27.12.2021.
//

import Foundation

import UIKit
struct CardsDataModel {
    
    var bgColor: UIColor
    var text : String
    var image : UIImageView
    var user : MUser
    
    init(bgColor: UIColor, text: String, image: UIImageView, user: MUser) {
        self.bgColor = bgColor
        self.text = text
        self.image = image
        self.user = user
    }
}
