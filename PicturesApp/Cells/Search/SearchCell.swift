//
//  SearchCell.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 6/4/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class SearchCell: UICollectionViewCell {
    static let cellId = "FollowerID"
    var picture: Picture? {
        didSet {
            guard let picture = picture else { return }
            self.pictureNameLabel.text = picture.title
            ImageManager.shared.downloadImage(urlString: picture.imageLink) { [unowned self] (image) in
                DispatchQueue.main.async {
                    self.pictureImageView.image = image
                }
            }
        }
    }
    
    private let pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.image = UIImage(named: "bwd")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let pictureNameLabel: PTDescriptionLabel = {
        let label = PTDescriptionLabel(textAlignment: .left)
        label.font = .systemFont(ofSize: 16)
        label.text = "Dana Katherine Scully"
        
        label.textColor = .black
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

        self.addSubview(pictureImageView)
        self.addSubview(pictureNameLabel)
        
        pictureImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        pictureImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8).isActive = true
        pictureImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
        let width = self.contentView.frame.width
        
        pictureImageView.heightAnchor.constraint(equalToConstant: width * 1.3).isActive = true
        
        pictureNameLabel.topAnchor.constraint(equalTo: self.pictureImageView.bottomAnchor, constant: 12).isActive = true
        pictureNameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8).isActive = true
        pictureNameLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8).isActive = true
        pictureNameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        self.pictureImageView.image = nil
//        self.pictureNameLabel.text = ""
    }
}
