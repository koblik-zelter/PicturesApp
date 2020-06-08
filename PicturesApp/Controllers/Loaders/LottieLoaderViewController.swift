//
//  LottieLoaderViewController.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/21/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit
import Lottie

class LottieLoaderViewController: UIViewController, AnimationDelegate {

    private let animationView: AnimationView = {
        let animationView = AnimationView(name: "mio")
        animationView.translatesAutoresizingMaskIntoConstraints = false
        return animationView
    }()

    private let containerView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.75)
//            .init(red: 1, green: 1, blue: 1, alpha: 0.75)
            //.init(red: 0, green: 0, blue: 0, alpha: 0.75)
        self.setupContainerView()
        // Do any additional setup after loading the view.
    }
    
    private func setupContainerView() {
        self.view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.backgroundColor = .systemBackground
//            .init(red: 0, green: 0, blue: 0, alpha: 0.75)
            //.systemBackground
        containerView.layer.cornerRadius = 10
        containerView.layer.borderWidth = 2.0
        containerView.layer.borderColor = UIColor.white.cgColor
//        containerView.alpha = 0.8
        containerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        containerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        containerView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        containerView.widthAnchor.constraint(equalToConstant: 250).isActive = true
    }
    
    func startAnimation() {
        self.animationView.contentMode = .scaleToFill
        self.animationView.loopMode = .playOnce
        self.animationView.animationSpeed = 2.0
        self.containerView.addSubview(animationView)
        
        self.animationView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor).isActive = true
        self.animationView.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor).isActive = true
        self.animationView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        self.animationView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        self.animationView.play { (bool) in
            self.stopAnimation()
        }
    }
    
    func stopAnimation() {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
