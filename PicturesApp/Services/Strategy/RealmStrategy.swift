//
//  RealmStrategy.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/24/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import Foundation

class RealmStrategy: SearchStrategy {
    func getPictures(name: String, handler: @escaping([Picture]) -> Void) {
        RealmService.shared.getPicture(name: name) { (pictures) in
            var pictureMap: [Picture] = []
            pictures.forEach { (picture) in
                pictureMap.append(Picture(pictureID: picture.imageId, title: picture.imageTitle, description: "test", imageLink: picture.imageLink, initialPrice: 150.00, author: nil))
            }
        }
    }
}
