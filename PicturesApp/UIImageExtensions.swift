//
//  UIImageExtensions.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 6/6/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

extension UIImageView
{
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // for supporting device rotation
        self.addSubview(blurEffectView)
    }
}
