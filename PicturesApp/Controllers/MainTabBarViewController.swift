//
//  MainTabBarViewController.swift
//  PicturesApp
//
//  Created by Alex Koblik-Zelter on 5/17/20.
//  Copyright © 2020 Alex Koblik-Zelter. All rights reserved.
//

import UIKit
import Firebase

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupUser()
    }
    
    private func setupUser() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let vc = ViewController()
                let navController = UINavigationController(rootViewController: vc)
                navController.modalPresentationStyle = .fullScreen
                navController.isNavigationBarHidden = true
                self.present(navController, animated: true)
            }
        }
        else {
            UserManager.shared.set(user: Auth.auth().currentUser!)
        }
    }
    
    private func setupViews() {
        let homeController = PopularViewController()
        let homeNavController = UINavigationController(rootViewController: homeController)
        homeNavController.tabBarItem.title = "Home"
        homeNavController.tabBarItem.image = UIImage(named: "home")
        UserManager.shared.add(subscriber: homeController)

        let searchController = SearchCategoryViewController()
        let searchNavController = UINavigationController(rootViewController: searchController)
        searchNavController.tabBarItem.title = "Search"
        searchNavController.tabBarItem.image = UIImage(named: "search1")
        
        let userController = UserViewController()
        let userNavController = UINavigationController(rootViewController: userController)
        userNavController.tabBarItem.title = "Profile"
        UserManager.shared.add(subscriber: userController)
        userNavController.tabBarItem.image = UIImage(named: "profile")
        tabBar.isTranslucent = false
        viewControllers = [homeNavController, searchNavController, userNavController]
    }

}
