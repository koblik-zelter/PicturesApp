//
//  PTLabel.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/21/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class PTLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    private func configure() {
        self.textColor = .label
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.9
        self.lineBreakMode = .byTruncatingTail
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
