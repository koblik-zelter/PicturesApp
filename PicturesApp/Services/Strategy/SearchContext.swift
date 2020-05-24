//
//  SearchContext.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/24/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import Foundation


class SearchContext {
    private var strategy: SearchStrategy
    
    init(strategy: SearchStrategy) {
        self.strategy = strategy
    }
    
    func getPictures(name: String, handler: @escaping([Picture]) -> Void) {
        self.strategy.getPictures(name: name) { (pictures) in
            handler(pictures)
        }
    }
    
    func setStrategy(_ strategy: SearchStrategy) {
        self.strategy = strategy
    }
    
}
