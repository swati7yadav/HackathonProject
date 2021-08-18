//
//  AppUtility.swift
//  HackathonProject
//
//  Created by Swati Yadav on 19/08/21.
//
import UIKit

class AppUtility {
    
    // MARK: - Format score & comment count
    class func formatPoints(num: Int) -> String {
        let newNum = String(num / 1000)
        var newNumString = "\(num)"
        
        if num > 1000 && num < 1000000 {
            newNumString = "\(newNum)k"
        } else if num > 1000000 {
            newNumString = "\(newNum)m"
        }
        return newNumString
    }
    
    // MARK: - Change feed image size dynamically
    class func getFeedImageHeight(image: UIImage, imageWidth: CGFloat, imageHeight: CGFloat) -> CGFloat {
        let imageRatio = image.getCropRatio(imageWidth: imageWidth, imageHeight: imageHeight)
        let feedImageHeight = UIScreen.main.bounds.width * imageRatio
        return feedImageHeight
    }
}
