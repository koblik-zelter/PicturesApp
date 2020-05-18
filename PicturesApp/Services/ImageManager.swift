//
//  ImageManager.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/17/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//


import UIKit

class ImageManager {
    static let shared = ImageManager()
    private var cache = NSCache<NSString, UIImage>()
    
    func getImage(named: String) -> UIImage? {
        let key = NSString(string: named)
        if let image = cache.object(forKey: key) {
            return image
        }
        print("Download image")
        return nil
    }
}
