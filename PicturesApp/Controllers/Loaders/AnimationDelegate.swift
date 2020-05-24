//
//  AnimationDelegate.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/20/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

protocol AnimationDelegate: class {
    func startAnimation()
    func stopAnimation()
}

enum LoaderType {
    case native
    case lottie
    case activity
}
