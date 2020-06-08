//
//  Updatable.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 6/7/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import Foundation
import Firebase

protocol Observable {
    func updateData(for user: User)
}
