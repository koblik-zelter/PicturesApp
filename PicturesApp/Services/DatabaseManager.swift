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
    private init() { }
    
    private let reference = Database.database().reference()

    func createUser(uid: String, userData: UserDetails, handler: @escaping(Error?) -> Void) {
        let ref = self.reference.child("Users")
        let userValues = ["firstName": userData.firstName, "secondName": userData.secondName, "imageURL": "", "linkedIn": userData.linkedinURL, "behance": userData.behanceURL]
        let values = [uid: userValues]
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                print("Fail to create user", err)
                handler(err)
            }
            else {
                print("success")
                handler(nil)
            }
        }
    }
    
    func getUser(uid: String, handler: @escaping(Result<UserDetails, Error>) -> Void) {
        let ref = self.reference.child("Users")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            
        }
    }
    
    func getPost(name: String, handler: @escaping([Picture]) -> Void) {
        // Global search
    }
    
    func getPostFromFavorites(name: String, handler: @escaping([Picture]) -> Void) {
        // Search pictures with name from favorites
    }
    
    func getAllPosts(handler: @escaping([Picture]) -> Void) {
        
    }
}
