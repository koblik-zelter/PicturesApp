//
//  FirebaseStrategy.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/24/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import Foundation

class FirebaseStrategy: SearchStrategy {
    func getPictures(name: String, handler: @escaping ([Picture]) -> Void) {
        DatabaseManager.shared.getPost(name: name) { (pictures) in
            guard let pictures = pictures else {
                handler([])
                return
            }
            handler(pictures)
        }
    }
    

}
