//
//  PictureDetailsViewController.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 6/5/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class PictureDetailsBottomViewController: UIViewController {
    
    private let pictureTitle = PTLabel(textAlignment: .left, fontSize: 18)
    private let authorLabel = PTLabel(textAlignment: .left, fontSize: 16)
    private let descriptionLabel = PTDescriptionLabel(textAlignment: .left)
    private let actionButton = PTButton(backgroundColor: .blue, title: "Add To Cart")
    
    private let priceLabel: PTLabel = {
        let label = PTLabel(textAlignment: .center, fontSize: 16)
        label.text = "$150.00"
        label.backgroundColor = .init(red: 86/255, green: 115/255, blue: 200/255, alpha: 1)
        label.textColor = .white
        label.layer.cornerRadius = 8
        label.clipsToBounds = true
        return label
    }()
    
    var picture: Picture? {
        didSet {
            guard let picture = picture else { return }
            self.pictureTitle.text = picture.title
            self.descriptionLabel.text = picture.description
            self.authorLabel.text = "Shika Treibich"
            self.priceLabel.text = "$\(picture.initialPrice)"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupPictureDetailsView()
        descriptionLabel.text = "Adele picture by Shika Treibich Adele picture by Shika Treibich Adele picture by Shika Treibich Adele picture by Shika Treibich Adele picture by Shika Treibich Adele picture by Shika Treibich Adele picture by Shika Treibich Adele picture by Shika Treibich Adele picture by Shika Treibich "
        self.setupViews()
    }
    
    fileprivate func setupPictureDetailsView() {
        let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(panGesture))
        view.addGestureRecognizer(gesture)
        self.roundViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.6, animations: {
            self.moveView(state: .full)
        })
    }
    
    private func moveView(state: State) {
        let yPosition = state == .partial ? Constant.partialViewYPosition : Constant.fullViewYPosition
        view.frame = CGRect(x: 0, y: yPosition, width: view.frame.width, height: view.frame.height)
    }

    private func moveView(panGestureRecognizer recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let minY = view.frame.minY
        
        if (minY + translation.y >= Constant.fullViewYPosition) && (minY + translation.y <= Constant.partialViewYPosition) {
            view.frame = CGRect(x: 0, y: minY + translation.y, width: view.frame.width, height: view.frame.height)
            recognizer.setTranslation(CGPoint.zero, in: view)
        }
    }
    
    @objc private func panGesture(_ recognizer: UIPanGestureRecognizer) {
        moveView(panGestureRecognizer: recognizer)
        
        if recognizer.state == .ended {
            UIView.animate(withDuration: 0.5, delay: 0.0, options: [.allowUserInteraction], animations: {
                let state: State = recognizer.velocity(in: self.view).y >= 0 ? .partial : .full
                self.moveView(state: state)
            }, completion: nil)
        }
    }
    
    private func roundViews() {
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
    }
    
    private func setupViews() {
        self.view.addSubview(pictureTitle)
        self.pictureTitle.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 16).isActive = true
        self.pictureTitle.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        self.view.addSubview(priceLabel)
        self.priceLabel.topAnchor.constraint(equalTo: self.pictureTitle.topAnchor).isActive = true
        self.priceLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        self.priceLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.priceLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.addSubview(authorLabel)
        self.authorLabel.topAnchor.constraint(equalTo: self.pictureTitle.bottomAnchor, constant: 8).isActive = true
        self.authorLabel.leadingAnchor.constraint(equalTo: self.pictureTitle.leadingAnchor).isActive = true
        
        self.view.addSubview(descriptionLabel)
        self.descriptionLabel.topAnchor.constraint(equalTo: self.authorLabel.bottomAnchor, constant: 8).isActive = true
        self.descriptionLabel.leadingAnchor.constraint(equalTo: self.pictureTitle.leadingAnchor).isActive = true
        self.descriptionLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -8).isActive = true
    }
}

extension PictureDetailsBottomViewController {
    fileprivate enum State {
        case partial
        case full
    }
    
    fileprivate enum Constant {
        static var fullViewYPosition: CGFloat { UIScreen.main.bounds.height * 2 / 3}
        static var partialViewYPosition: CGFloat { UIScreen.main.bounds.height - 130 }
    }
}
