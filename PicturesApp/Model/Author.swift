//
//  Author.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/16/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import Foundation

struct Author: Codable {
    var id: String
    var userDetails: UserDetails

}

struct UserDetails: Codable {
    var firstName: String
    var secondName: String
    var imageLink: String?
    var linkedinURL: String?
    var behanceURL: String?
}
