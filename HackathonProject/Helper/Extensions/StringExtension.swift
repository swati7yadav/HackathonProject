//
//  StringExtension.swift
//  HackathonProject
//
//  Created by Swati Yadav on 19/08/21.
//

import Foundation

// MARK: - Check if url string returns a valid image
extension String {
    
    func isImage() -> Bool {
        // Add here your image formats.
        let imageFormats = ["jpg", "jpeg", "png", "gif"]
        
        if let ext = self.getExtension() {
            return imageFormats.contains(ext)
        }
        return false
    }
    
    func getExtension() -> String? {
        let ext = (self as NSString).pathExtension
        
        if ext.isEmpty {
            return nil
        }
        return ext
    }
    
    func isURL() -> Bool {
        return URL(string: self) != nil
    }
}
