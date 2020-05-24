//
//  ViewControllerExtensions.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/17/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit

fileprivate var containerView: UIView!

extension UIViewController {
    func dismissKey() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    
    func addChildVC(_ viewController: UIViewController, at view: UIView) {
        self.addChild(viewController)
        view.addSubview(viewController.view)
        viewController.view.frame = view.bounds
        viewController.didMove(toParent: self)
    }
    
    func showAlert(title: String, message: String, action: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            let vc = CustomAlertController(alertTitle: title, alertDescription: message, buttonTitle: action)
            vc.modalPresentationStyle = .overFullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
        })
    }
    
    func showAnimation() {
        let vc = LoaderFactory.shared.getLoaderByType(.lottie)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
        vc.startAnimation()
    }
    
    func dismissAnimation() {
        let vc = LoaderFactory.shared.getCurrentLoader()
        vc.stopAnimation()
    }
}
