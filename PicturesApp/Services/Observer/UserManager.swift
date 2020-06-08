//
//  Observer.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 6/7/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import Foundation
import Firebase

class UserManager {
    private lazy var subscribers: [Observable] = []
    private var currentUser: User!
    static var shared = UserManager()

    
    private init() { }
    
    func add(subscriber: Observable) {
        print("CartManager: I'am adding a new subscriber")
        subscribers.append(subscriber)
    }

    func set(user: User) {
        print("\nCartManager: I'am adding a new product:")
        currentUser = user
        notifySubscribers()
    }

    func remove(subscriber filter: (Observable) -> (Bool)) {
        guard let index = subscribers.firstIndex(where: filter) else { return }
        subscribers.remove(at: index)
    }
    
    private func notifySubscribers() {
        subscribers.forEach( { $0.updateData(for: currentUser) })
//        subscribers.forEach({ $0.accept(changed: currentUser) })
    }

}
