//
//  ViewController.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/16/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit
import Firebase
import SkyFloatingLabelTextField

class ViewController: UIViewController {
    
    private let signInLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Войти"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let signUpButton: AttributedButton = {
        let button = AttributedButton(title: "Don't have an account?   ", actionString: "Sign Up")
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return button
    }()
    
    private let signInButton: AuthButton = {
        let button = AuthButton(title: "Sign In")
        button.backgroundColor = .init(red: 124/255, green: 158/255, blue: 169/255, alpha: 1)
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField: AuthSkyTextField = {
        let tf = AuthSkyTextField(title: "Email")
        return tf
    }()
    
    private let passwordTextField: AuthSkyTextField = {
        let tf = AuthSkyTextField(title: "Password")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "bns")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.dismissKey()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .systemBackground
        self.configureSignInLabel()
        self.configureSignUpButton()
        self.configureEmailTextField()
        self.configureBackgroundImage()
        self.configureSignInButton()

    }
    
    private func configureSignInLabel() {
        self.view.addSubview(signInLabel)
        self.signInLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 64).isActive = true
        self.signInLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        self.signInLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func configureSignUpButton() {
        self.view.addSubview(signUpButton)
        self.signUpButton.topAnchor.constraint(equalTo: self.signInLabel.bottomAnchor, constant: 24).isActive = true
        self.signUpButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
//        self.signUpButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    private func configureEmailTextField() {
        let stackView = UIStackView(arrangedSubviews: [self.emailTextField, self.passwordTextField])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        self.view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.signUpButton.bottomAnchor, constant: 24).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 116).isActive = true
//        loginButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
    }
    
    private func configureSignInButton() {
        self.view.addSubview(signInButton)
        self.signInButton.topAnchor.constraint(equalTo: self.passwordTextField.bottomAnchor, constant: 32).isActive = true
        self.signInButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        self.signInButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.signInButton.widthAnchor.constraint(equalToConstant: 100).isActive = true

    }

    private func configureBackgroundImage() {
        self.view.addSubview(self.backgroundImage)
        
        self.backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.backgroundImage.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        let height = self.view.frame.height * 0.5
        let width = self.view.frame.width * 0.8
        
        self.backgroundImage.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.backgroundImage.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    @objc private func signUp() {
        let vc = SignUpViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

