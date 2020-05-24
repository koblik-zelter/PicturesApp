//
//  CircleAnimationViewController.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/20/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

class CircleAnimationViewController: UIViewController, AnimationDelegate {

    private let containerView = UIView()
    private var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.75)
    }
    
    private func setupContainerView() {
        self.view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 2.0
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.alpha = 0.8
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(activityIndicator)
        
        activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
    }
    
    func startAnimation() {
        self.setupContainerView()
        activityIndicator.startAnimating()
    }
    
    func stopAnimation() {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
