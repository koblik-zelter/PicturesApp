//
//  SignUpViewController.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/17/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Lottie
class SignUpViewController: UIViewController {
    
    private let signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Cоздать учетную запись"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    private let signInButton: AttributedButton = {
        let button = AttributedButton(title: "Don't have an account?   ", actionString: "Sign Up")
        button.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        return button
    }()
    
    private let emailTextField: RegistrSkyTextField = {
        let tf = RegistrSkyTextField(title: "Email *")
        return tf
    }()
    
    private let passwordTextField: RegistrSkyTextField = {
        let tf = RegistrSkyTextField(title: "Password *")
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let userFirstNameTextField: RegistrSkyTextField = {
        let tf = RegistrSkyTextField(title: "First name *")
        return tf
    }()
    
    private let userSecondNameTextField: RegistrSkyTextField = {
        let tf = RegistrSkyTextField(title: "Second name *")
        return tf
    }()
    
    private let linkedInURL: RegistrSkyTextField = {
        let tf = RegistrSkyTextField(title: "LinkedIn link")
        return tf
    }()
    
    private let behanceURL: RegistrSkyTextField = {
        let tf = RegistrSkyTextField(title: "Behance link")
        return tf
    }()
    
    private let signUpButton: AuthButton = {
        let button = AuthButton(title: "Sign Up")
        button.backgroundColor = .init(red: 86/255, green: 115/255, blue: 200/255, alpha: 1)
        button.addTarget(self, action: #selector(signUp), for: .touchUpInside)
        return button
    }()
    
    private let backgroundImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "b")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismissKey()
        self.setupViews()
    }
    
    private func setupViews() {
        self.view.backgroundColor = .systemBackground
        self.configureSignUpLabel()
        self.configureSignInButton()
        self.configureTextFields()
        self.configureSignUpButton()
        self.configureBackgroundImage()
    }
    
    private func configureTextFields() {
        let stackView = UIStackView(arrangedSubviews: [self.emailTextField, self.userFirstNameTextField, self.userSecondNameTextField, self.passwordTextField, self.linkedInURL, self.behanceURL])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        
        self.view.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.signInButton.bottomAnchor, constant: 24).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 364).isActive = true
    }
    
    private func configureSignInButton() {
        self.view.addSubview(signInButton)
        self.signInButton.topAnchor.constraint(equalTo: self.signUpLabel.bottomAnchor, constant: 8).isActive = true
        self.signInButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
    }
    
    private func configureSignUpButton() {
        self.view.addSubview(signUpButton)
        self.signUpButton.topAnchor.constraint(equalTo: self.behanceURL.bottomAnchor, constant: 16).isActive = true
        self.signUpButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        self.signUpButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.signUpButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func configureSignUpLabel() {
        self.view.addSubview(signUpLabel)
        self.signUpLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 48).isActive = true
        self.signUpLabel.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
        self.signUpLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    private func configureBackgroundImage() {
        self.view.addSubview(self.backgroundImage)
        
        self.backgroundImage.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.backgroundImage.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        
        let height = self.view.frame.height * 0.35
        let width = self.view.frame.width * 0.6
        
        self.backgroundImage.heightAnchor.constraint(equalToConstant: height).isActive = true
        self.backgroundImage.widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    @objc private func signIn() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func signUp() {
        guard let email = emailTextField.text,
            let password = passwordTextField.text,
            let userFirstName = userFirstNameTextField.text,
            let userSecondName = userSecondNameTextField.text else { return }
        
        //optional
        let linkedInUrl = linkedInURL.text
        let behanceUrl = behanceURL.text
    
        let userDetails = UserDetails(firstName: userFirstName, secondName: userSecondName, linkedinURL: linkedInUrl, behanceURL: behanceUrl)
        AuthFacade.shared.register(email: email, password: password, userDetails: userDetails) { (err) in
            if let error = err {
                self.showAlert(title: "Registration Error", message: error.localizedDescription, action: "Ok")
                return
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
}
