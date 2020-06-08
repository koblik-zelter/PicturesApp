//
//  ImageDownloaderService.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 6/5/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

protocol ImageDownloaderService {
    func downloadImage(urlString: String, handler: @escaping(UIImage?) -> ())
}
