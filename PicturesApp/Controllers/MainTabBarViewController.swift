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
        self.setupUser()
        self.setupViews()
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
//        else { print(Auth.auth().currentUser?.uid) }
    }
    
    private func setupViews() {
        let homeController = PopularViewController()
        let homeNavController = UINavigationController(rootViewController: homeController)
        homeNavController.tabBarItem.title = "home"
//        homeNavController.tabBarItem.image = UIImage(named: "home-0")
        let searchController = SearchViewController()
        let searchNavController = UINavigationController(rootViewController: searchController)
        searchNavController.tabBarItem.title = "search"

//        searchNavController.tabBarItem.image = UIImage(named: "cooking")
        
        let savedController = PopularViewController()
        let savedNavController = UINavigationController(rootViewController: savedController)
        savedNavController.tabBarItem.title = "saved"

//        savedNavController.tabBarItem.image = UIImage(named: "pin")
        
        //        let aboutUsController = AboutUsViewController()
        //        let aboutUsNavController = UINavigationController(rootViewController: aboutUsController)
        //        aboutUsNavController.tabBarItem.image = UIImage(named: "profile-0")
//        tabBar.tintColor = UIColor(named: "TabColor")
        tabBar.isTranslucent = false
        viewControllers = [homeNavController, searchNavController, savedNavController]
    }

}
