//
//  UserDetailsBuilder.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 6/7/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import Foundation

protocol Builder {
    func setLinkedin(url: String)
    func setBehance(url: String)
    func getUserData() -> UserDetails
}

class UserBuilder: Builder {
    private var userDetails: UserDetails!
    
    init(firstName: String, secondName: String) {
        self.userDetails = UserDetails(firstName: firstName, secondName: secondName)
    }
    
    func setLinkedin(url: String) {
        self.userDetails.linkedinURL = url
    }
    
    func setBehance(url: String) {
        self.userDetails.behanceURL = url
    }
    
    func getUserData() -> UserDetails {
        return self.getUserData()
    }
}
