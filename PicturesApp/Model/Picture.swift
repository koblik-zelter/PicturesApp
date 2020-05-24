//
//  Picture.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/16/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import Foundation

struct Picture: Codable {
    var pictureID: String
    var title: String
    var description: String
    var imageLink: String
    var initialPrice: Float
    var author: Author
}
