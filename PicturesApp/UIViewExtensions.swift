//
//  UIViewExtensions.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 6/7/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

extension UIView {
    func pinViewTo(_ view: UIView) {
        topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
