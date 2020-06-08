//
//  UserExternalDetailsViewController.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 6/7/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class UserExternalDetailsViewController: UIViewController {

    private let stackView = UIStackView()
    private let itemInfoViewOne = PTInfoView()
    private let itemInfoViewTwo = PTInfoView()
    
    let actionButton = PTButton()
    
    weak var delegate: BehanceDelegate?
//    var user: User!
//
//    init(type: ItemTypes, user: User) {
//        super.init(nibName: nil, bundle: nil)
//        self.itemType = type
//        self.user = user
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureBackgroundView()
        self.layoutUI()
        self.configureStackView()
        self.configureItems()
    }
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackView() {
        self.stackView.axis = .horizontal
        self.stackView.distribution = .equalSpacing
        
        self.stackView.addArrangedSubview(itemInfoViewOne)
        self.stackView.addArrangedSubview(itemInfoViewTwo)
    }
    
    private func layoutUI() {
        view.addSubview(stackView)
        view.addSubview(actionButton)
        self.actionButton.addTarget(self, action: #selector(didTapActionButton), for: .touchUpInside)
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        let padding: CGFloat = 20
        
      
        stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding).isActive = true
        actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding).isActive = true
        actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding).isActive = true
        actionButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
    }
    
    func configureItems() {
        self.itemInfoViewOne.set(itemInfoType: .likes, withCount: 10)
        self.itemInfoViewTwo.set(itemInfoType: .posts, withCount: 15)
        self.actionButton.set(backgroundColor: .init(red: 86/255, green: 115/255, blue: 200/255, alpha: 1), title: "Behance Profile")
    }
    
    @objc private func didTapActionButton() {
        self.delegate?.didTapOnBehanceProfile()
    }
}
