//
//  ImageManager.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/17/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//


import UIKit

class ImageManager: ImageDownloaderService {
    static let shared = ImageManager()
    private var cache = NSCache<NSString, UIImage>()
    private let imageDownloader = ImageDownloader.shared
    
    func downloadImage(urlString: String, handler: @escaping(UIImage?) -> ()) {
        let key = NSString(string: urlString)

        if let image = cache.object(forKey: key) {
            handler(image)
        }
        else {
            self.imageDownloader.downloadImage(urlString: urlString) { [unowned self] (image) in
                guard let image = image else { return }
                self.cache.setObject(image, forKey: key)
                handler(image)
            }
        }
    }
}
