//
//  PopularCell.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/24/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class PopularCell: UICollectionViewCell {
    private var gradientView: UIView!
    
    var picture: Picture? {
        didSet {
            guard let picture = picture else { return }
            self.imageName.text = picture.title
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
//        imageView.backgroundColor = .lightGray
//        imageView.image = UIImage(named: "bwd")
        return imageView
    }()
    
    private let imageName: PTDescriptionLabel = {
        let label = PTDescriptionLabel(textAlignment: .center)
        label.textColor = .white
        label.numberOfLines = 3
        label.text = "Test story description"
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
        self.contentView.backgroundColor = .init(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        self.configureGradient()
        self.configureImageView()
        self.configureImageName()
    }
    
    private func configureGradient() {
        self.gradientView = UIView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height))
        let gradient = CAGradientLayer()
        gradient.frame = gradientView.bounds
        gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientView.layer.insertSublayer(gradient, at: 0)
        gradientView.alpha = 0.5
        gradientView.layer.cornerRadius = 12
        gradientView.layer.masksToBounds = true
      
    }
    
    private func configureImageView() {
        self.contentView.addSubview(imageView)
        imageView.addSubview(gradientView)

        imageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 3).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
            
        gradientView.centerYAnchor.constraint(equalTo: self.imageView.centerYAnchor).isActive = true
        gradientView.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor).isActive = true
    }
    
    private func configureImageName() {
        self.contentView.addSubview(imageName)
        
        imageName.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -10).isActive = true
        imageName.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 8).isActive = true
        imageName.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -8).isActive = true
    }
    
}
