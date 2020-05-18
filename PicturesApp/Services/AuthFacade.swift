//
//  AuthFacade.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/16/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import Foundation
import MessageUI

class AuthFacade {
    static let shared = AuthFacade()
    private init() { }
    
    func auth(user: Author, email: String, password: String, handler: @escaping(Result<String, Error>) -> Void) {
        let authService = MailAuthService()
        
        authService.auth(email: email, password: password) { (result) in
            switch result {
            case.success(let user):
                DatabaseManager.shared.createUser(user: user)
                break
            case.failure(let err):
                handler(.failure(err))
                break
            }
        }
    }
}
