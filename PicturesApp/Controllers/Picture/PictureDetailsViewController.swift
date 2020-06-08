//
//  PictureDetailsBottomViewController.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 6/6/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit
import SPAlert

class PictureDetailsViewController: UIViewController {

    var picture: Picture? {
        didSet {
            guard let picture = picture else { return }
            ImageManager.shared.downloadImage(urlString: picture.imageLink) { [unowned self] (image) in
                DispatchQueue.main.async {
                    self.pictureImageView.image = image
                    self.backgroundImageView.image = image
                }
            }
        }
    }
    
    private let backgroundImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "bwd")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let pictureImageView: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.clipsToBounds = true
        iv.image = UIImage(named: "bwd")
        iv.layer.cornerRadius = 16
        return iv
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "back48"), for: .normal)
        button.layer.cornerRadius = 18
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        return button
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "like"), for: .normal)
        button.layer.cornerRadius = 18
        button.contentMode = .scaleAspectFill
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(addToFavorites), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.addBottomSheetView()
    }
    
    private func addBottomSheetView() {
        let bottomSheetVC = PictureDetailsBottomViewController()
        bottomSheetVC.picture = self.picture
        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)
        
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: view.frame.maxY, width: width, height: height)
    }
    
    fileprivate func setupViews() {
        self.view.addSubview(backgroundImageView)
        backgroundImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.addBlurEffect()
        
        self.view.addSubview(backButton)
        self.view.addSubview(likeButton)
        backButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        likeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        likeButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -32).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 36).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 36).isActive = true
        
        
        self.view.addSubview(pictureImageView)
        pictureImageView.topAnchor.constraint(equalTo: self.likeButton.bottomAnchor, constant: 16).isActive = true
        pictureImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 32).isActive = true
        let width = self.view.bounds.width - 64
        let height = width * 1.48 - 32
        pictureImageView.widthAnchor.constraint(equalToConstant: width).isActive = true
        pictureImageView.heightAnchor.constraint(equalToConstant: height).isActive = true
    }

    @objc private func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func addToFavorites() {
        print("Did tap on like")
        DatabaseManager.shared.addToFavorites(picture: self.picture!) { (err) in
            if let err = err {
                self.showAlert(title: "Error", message: err, action: "Ok")
                return
            }
            self.showDoneAlert(title: "Added to Favorites")
        }
    }
}
