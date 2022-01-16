//
//  UIImage + Extension.swift
//  Chat
//
//  Created by Alexandr Yakovlev on 13.01.2022.
//

import UIKit

extension UIImage {
    
    var scaledToSafeUploadSize: UIImage? {
        let maxImageSideLenght: CGFloat = 480
        
        let largeSide: CGFloat = max(size.width, size.height)
        let ratioScale: CGFloat = largeSide > maxImageSideLenght ? largeSide / maxImageSideLenght :  1
        let newImageSize = CGSize(width: size.width / ratioScale, height: size.height / ratioScale)
        
        return image(scaledTo: newImageSize)
    }
    
    func image(scaledTo size: CGSize) -> UIImage? {
        defer {
            UIGraphicsEndImageContext()
        }
        
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        draw(in: CGRect(origin: .zero, size: size))
        
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
