//
//  FavoritesStrategy.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/24/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import Foundation

class FavoritesStrategy: SearchStrategy {
    func getPictures(name: String, handler: @escaping ([Picture]) -> Void) {
        DatabaseManager.shared.getPostFromFavorites(name: name) { (pictures) in
            print("Favorites")
            handler(pictures)
        }
    }
    
    
}
