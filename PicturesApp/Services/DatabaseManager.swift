//
//  DatabaseManager.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/16/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import Foundation
import Firebase

class DatabaseManager {
    static let shared = DatabaseManager()
    private let reference = Database.database().reference()

    func createUser(user: Author) {
        let ref = self.reference.child("Users")
        let userValues = ["username": user.name]
        let values = ["uid": userValues]
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                print("Fail to create user", err)
            }
            else {
                print("success")
            }
        }
    }
}
