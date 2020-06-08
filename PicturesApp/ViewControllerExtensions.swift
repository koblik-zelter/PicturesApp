//
//  ViewControllerExtensions.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/17/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit
import SPAlert

fileprivate var containerView: UIView!
fileprivate var emptyView: UIView!

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
    
    func showDoneAlert(title: String) {
        DispatchQueue.main.async {
            let alert = SPAlertView(title: title, message: nil, preset: SPAlertPreset.done)
            alert.duration = 3.0
            alert.present()
        }
    }
    
    func showAnimation() {
        let type = UserDefaults.standard.object(forKey: "loaderType") as? String ?? ""
        let loaderType = LoaderType.init(rawValue: type) ?? LoaderType.activity
        
        let vc = LoaderFactory.shared.getLoaderByType(loaderType)
        vc.modalPresentationStyle = .overFullScreen
        vc.modalTransitionStyle = .crossDissolve
        self.present(vc, animated: true, completion: nil)
        vc.startAnimation()
    }
    
    func dismissAnimation() {
        let vc = LoaderFactory.shared.getCurrentLoader()
        vc.stopAnimation()
    }
    
    func showEmptyView(with message: String, in view: UIView) {
        emptyView = EmptyStateView(message: message)
        emptyView.frame = view.bounds
        view.addSubview(emptyView)
    }
    
    func removeEmptyView() {
        if let emptyView = emptyView {
            emptyView.alpha = 0
        }
    }
}
