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
    
    func postImage(picture: Picture) {
        let ref = reference.child("Popular").childByAutoId()
        let values = ["title": picture.title, "description": picture.description, "imageLink": picture.imageLink, "initialPrice":picture.initialPrice, "authorID": picture.authorID] as [String : Any]
        
        ref.updateChildValues(values) { (err, ref) in
            if let err = err {
                print("Failed to save post to DB", err)
                return
            }
            print("did save")
        }
    }
    
    func getUser(uid: String, handler: @escaping(Result<Author, Error>) -> Void) {
        let ref = self.reference.child("Users").child(uid)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionary = snapshot.value as? [String: Any] else {
                return
            }
            let author = Author(id: snapshot.key, userDetails: UserDetails(data: dictionary))
            handler(.success(author))
//            let picture = Picture(id: key, data: dictionary)
        }
    }
    
    func getPost(name: String, handler: @escaping([Picture]?) -> Void) {
        let ref = self.reference.child("Popular").queryOrdered(byChild:  "title").queryStarting(atValue: name).queryEnding(atValue: name + "\u{f8ff}")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionaries = snapshot.value as? [String: Any] else {
                handler(nil)
                return
            }
            var pictures: [Picture] = []
            dictionaries.forEach { (key, value) in
                guard let dictionary = value as? [String: Any] else { return }
                let picture = Picture(id: key, data: dictionary)
                pictures.append(picture)
            }
            handler(pictures)
        }
    }
    
    func getPostFromFavorites(name: String, handler: @escaping([Picture]?) -> Void) {
        // Search pictures with name from favorites
        guard let user = Auth.auth().currentUser else { return }
        let ref = self.reference.child("Favorites").child(user.uid).queryOrdered(byChild:  "title").queryStarting(atValue: name).queryEnding(atValue: name + "\u{f8ff}")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionaries = snapshot.value as? [String: Any] else {
                handler(nil)
                return
            }
            var pictures: [Picture] = []
            dictionaries.forEach { (key, value) in
                guard let dictionary = value as? [String: Any] else { return }
                let picture = Picture(id: key, data: dictionary)
                pictures.append(picture)
            }
            handler(pictures)
        }
    }
    
    func getAllPosts(handler: @escaping([Picture]) -> Void) {
        
    }
    
    func getPostsFrom(path: String, handler: @escaping([Picture]?) -> Void) {
        let ref = self.reference.child(path)
        ref.observeSingleEvent(of: .value) { (snapshot) in
            guard let dictionaries = snapshot.value as? [String: Any] else {
                handler(nil)
                return
            }
            var pictures: [Picture] = []
            dictionaries.forEach { (key, value) in
                guard let dictionary = value as? [String: Any] else { return }
                let picture = Picture(id: key, data: dictionary)
                pictures.append(picture)
            }
            handler(pictures)
        }
    }
    
    func addToFavorites(picture: Picture, handler: @escaping(String?) -> Void) {
        guard let currentUser = Auth.auth().currentUser else { return }
        let ref = self.reference.child("Favorites").child(currentUser.uid).child(picture.pictureId)
        let values = ["title": picture.title, "description": picture.description, "imageLink": picture.imageLink, "initialPrice": picture.initialPrice, "authorID": "ShikaId"] as [String : Any]
        ref.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.exists() {
                handler("Already in Favorites")
                return
            }
            
            ref.updateChildValues(values) { (err, ref) in
                if let error = err {
                    handler(error.localizedDescription)
                    return
                }
                handler(nil)
            }
        }
        
    }
}
