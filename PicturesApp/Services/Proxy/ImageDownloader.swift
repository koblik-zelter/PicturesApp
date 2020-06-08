//
//  ImageDownloader.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 6/4/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
class ImageDownloader: ImageDownloaderService {
    static let shared = ImageDownloader()
    private let storage: Storage!
    private init() { self.storage = Storage.storage() }
    
    func downloadImage(urlString: String, handler: @escaping(UIImage?) -> ()) {
        var image: UIImage?
        
        let ref = storage.reference(forURL: urlString)
        ref.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                return
            }
            guard let data = data else { return }
            image = UIImage(data: data)
            handler(image)
        }
    }
}
