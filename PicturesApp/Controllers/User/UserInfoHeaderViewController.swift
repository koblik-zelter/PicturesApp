//
//  UserInfoHeaderViewController.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 6/7/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class UserInfoHeaderViewController: UIViewController {
    
    let avatarImageView = UIImageView()
    let usernameLabel = PTLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = PTLabel(textAlignment: .left, fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = PTLabel(textAlignment: .left, fontSize: 18)
    let bioLabel = PTDescriptionLabel(textAlignment: .left)
    
    var user: Author! {
        didSet {
            configureUIElements()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }
    
    func configureUIElements() {
//        avatarImageView.setImage(urlString: user.avatarUrl)
        avatarImageView.image = UIImage(named: "avatar-placeholder")
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 10
        
        usernameLabel.text = user.userDetails.firstName + " " + user.userDetails.secondName
//        = "Shika Treibich"
        locationLabel.text = "Israel, Tel-Aviv"
        locationLabel.textColor = .secondaryLabel
        bioLabel.text =  "No bio available"
        bioLabel.numberOfLines = 3
        
        locationImageView.image = UIImage(systemName: "mappin.and.ellipse")
        locationImageView.tintColor = .secondaryLabel
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layoutUI() {
        let views = [avatarImageView, usernameLabel, nameLabel, locationImageView, locationLabel, bioLabel]
        
        views.forEach { self.view.addSubview($0) }
        
        avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        avatarImageView.heightAnchor.constraint(equalToConstant: 90).isActive = true
        avatarImageView.backgroundColor = .gray
        
        usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor).isActive = true
        usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16).isActive = true
        usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        usernameLabel.heightAnchor.constraint(equalToConstant: 36).isActive = true
//
//        nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8).isActive = true
//        nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16).isActive = true
//        nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//        nameLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
        locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor).isActive = true
        locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 12).isActive = true
        locationImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        locationImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
        locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor).isActive = true
        locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 8).isActive = true
        locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            
        bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 16).isActive = true
        bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor).isActive = true
        bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bioLabel.heightAnchor.constraint(equalToConstant: 64).isActive = true
    }
}
