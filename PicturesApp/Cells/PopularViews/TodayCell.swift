//
//  TodayCell.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/24/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    var picture: Picture? {
        didSet {
            guard let picture = picture else { return }
            self.priceLabel.text = "$\(picture.initialPrice)"
            self.pictureNameLabel.text = picture.title
            ImageManager.shared.downloadImage(urlString: picture.imageLink) { (image) in
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
//       imageView.image = UIImage(named: "a")
        return imageView
    }()
    
    private let pictureNameLabel: PTLabel = {
        let label = PTLabel(textAlignment: .left, fontSize: 18)
        label.text = "Dana Katherine Scully"
        label.textColor = .black
        return label
    }()
    
    private let authorNameLabel: PTLabel = {
        let label = PTLabel(textAlignment: .left, fontSize: 14)
        label.textColor = .lightGray
        label.text = "Shika Treibich"
        return label
    }()
    
    private let priceLabel: PTLabel = {
        let label = PTLabel(textAlignment: .center, fontSize: 16)
        label.text = "$150.00"
        label.backgroundColor = .init(red: 86/255, green: 115/255, blue: 200/255, alpha: 1)
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        self.backgroundColor = .init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        self.configureImageView()
        self.configureStackView()
        self.configurePriceLabel()
    }
    
    private func configureImageView() {
        self.contentView.addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16).isActive = true
        imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16).isActive = true
        
        let width = contentView.bounds.width / 2 - 32
        imageView.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    private func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: [self.pictureNameLabel, self.authorNameLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 4
        
        self.contentView.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 32).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func configurePriceLabel() {
        self.contentView.addSubview(priceLabel)
        priceLabel.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: -16).isActive = true
        priceLabel.leadingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: 16).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        priceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
}
