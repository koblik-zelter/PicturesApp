//
//  LabelFactory.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/17/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class SkyTextField: SkyFloatingLabelTextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String) {
        super.init(frame: .zero)
        self.configure()
        self.title = title
    }

    private func configure() {
        self.textColor = .label
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
//        self.selectedLineColor = .init(red: 81/255, green: 135/255, blue: 237/255, alpha: 1)
        self.lineColor = .lightGray
        self.setTitleVisible(true)
    }
}

class AuthSkyTextField: SkyTextField {
    override init(title: String) {
        super.init(title: title)
        self.selectedTitleColor = .init(red: 124/255, green: 158/255, blue: 169/255, alpha: 1)
        self.selectedLineColor = .init(red: 124/255, green: 158/255, blue: 169/255, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RegistrSkyTextField: SkyTextField {
    override init(title: String) {
        super.init(title: title)
        self.selectedTitleColor = .init(red: 86/255, green: 115/255, blue: 200/255, alpha: 1)
        self.selectedLineColor = .init(red: 86/255, green: 115/255, blue: 200/255, alpha: 1)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

