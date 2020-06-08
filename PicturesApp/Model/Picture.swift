//
//  Picture.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/16/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import Foundation

struct Picture: Codable {
    var pictureId: String
    var title: String
    var description: String
    var imageLink: String
    var initialPrice: Float
    var authorID: String
    
    init(id: String, data: Dictionary<String, Any>) {
        self.pictureId = id
        self.title = data["title"] as? String ?? ""
        self.description = data["description"] as? String ?? ""
        self.imageLink = data["imageLink"] as? String ?? ""
        self.initialPrice = data["initialPrice"] as? Float ?? 0
        self.authorID = data["authorID"] as? String ?? ""
    }
}

extension Picture : Hashable {
    static func ==(lhs: Picture, rhs: Picture) -> Bool {
        return lhs.pictureId == rhs.pictureId
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(pictureId)
    }
}
