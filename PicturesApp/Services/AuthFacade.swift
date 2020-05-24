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
    
    func register(email: String, password: String, userDetails: UserDetails, handler: @escaping(Error?) -> Void) {
        
        MailAuthService.shared.createUser(email: email, password: password) { (result) in
            switch result {
                case.success(let firebaseUser):
                    DatabaseManager.shared.createUser(uid: firebaseUser.uid, userData: userDetails) { (err) in
                        if let err = err {
                            handler(err)
                            return
                        }
                        handler(nil)
                    }
                case.failure(let err):
                    handler(err)
                    break
            }
        }
    }
    
    func auth(email: String, password: String, handler: @escaping(Error?) -> Void) {
        MailAuthService.shared.auth(email: email, password: password) { (err) in
            if let error = err {
                handler(error)
                return
            }
            handler(nil)
        }
    }
}
