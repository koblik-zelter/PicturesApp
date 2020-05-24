//
//  LoaderFactoryMethod.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/21/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

typealias AnimationController = UIViewController & AnimationDelegate

class LoaderFactory {
    static let shared = LoaderFactory()
    
    private var loader: AnimationController!
    
    func getLoaderByType(_ type: LoaderType) -> AnimationController {
        switch type {
        case .activity:
            self.loader = CircleAnimationViewController()
            break
        case .lottie:
            self.loader = LottieLoaderViewController()
            break
        case .native:
            break
        }
        return self.loader
    }
    
    func getCurrentLoader() -> AnimationController {
        return self.loader
    }
}
