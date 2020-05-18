//
//  AttributedButton.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/17/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class AttributedButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, actionString: String) {
        self.init(frame: .zero)
        let attributedTitle = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        attributedTitle.append(NSMutableAttributedString(string: actionString, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor(red: 86/255, green: 115/255, blue: 200/255, alpha: 1)]))
        self.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    private func configure() {

        self.contentHorizontalAlignment = .leading
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
