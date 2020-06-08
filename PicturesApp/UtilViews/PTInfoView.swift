//
//  PTInfoView.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 6/7/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit
enum ItemInfoType {
    case likes, posts
}
class PTInfoView: UIView {
    
    let symbolImageView = UIImageView()
    let titleLabel = PTLabel(textAlignment: .left, fontSize: 14)
    let countLabel = PTLabel(textAlignment: .center, fontSize: 14)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        self.addSubview(symbolImageView)
        self.addSubview(titleLabel)
        self.addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor   = .label
        
        symbolImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        symbolImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        symbolImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
        
        countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4).isActive = true
        countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        countLabel.heightAnchor.constraint(equalToConstant: 18).isActive = true
    }
    
    
    func set(itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
            case .likes:
                symbolImageView.image = UIImage(systemName: "heart")
                titleLabel.text = "Posts"
            case .posts:
                symbolImageView.image = UIImage(systemName: "person.2")
                titleLabel.text = "Followers"
        }
        countLabel.text = String(count)
    }
}
