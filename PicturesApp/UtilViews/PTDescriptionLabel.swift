//
//  PTDescriptionLabel.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/21/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class PTDescriptionLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    private func configure() {
        self.textColor = .secondaryLabel
        self.font = UIFont.preferredFont(forTextStyle: .body)
        self.adjustsFontForContentSizeCategory = true
        self.adjustsFontSizeToFitWidth = true
        self.minimumScaleFactor = 0.75
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
