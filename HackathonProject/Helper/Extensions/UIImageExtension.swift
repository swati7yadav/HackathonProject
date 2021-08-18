//
//  UIImageExtension.swift
//  HackathonProject
//
//  Created by Swati Yadav on 19/08/21.
//

import UIKit

// MARK: - Get crop ratio for based on resolution of image
extension UIImage {
    
    func getCropRatio(imageWidth: CGFloat, imageHeight: CGFloat) -> CGFloat {
        let widthRatio = CGFloat(imageWidth / imageHeight)
        return widthRatio
    }
}
