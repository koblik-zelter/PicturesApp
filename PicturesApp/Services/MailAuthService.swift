//
//  MailAuthService.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/16/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import Foundation
import Firebase

class MailAuthService {
    static let shared = MailAuthService()
    
    private init() { }
    
    func createUser(email: String, password: String, handler: @escaping(Result<User, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
            if let error = error {
                handler(.failure(error))
                return
            }
            guard let user = result?.user else { return }
            handler(.success(user))
        }
    }
    
    func resetPassword(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { (err) in
            
        }
    }
    
    func auth(email: String, password: String, handler: @escaping(Error?) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                handler(error)
                return
            }
            
            if let _ = result?.user {
                handler(nil)
            }
        }
    }
    
}
