//
//  TabBarController.swift
//  TMDB App
//
//  Created by Carlos Paredes on 21/3/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    private func setUpTabs() {
        let homeVC = HomeViewController()
        let favoritesVC = FavoritesViewController()
        
        homeVC.navigationItem.largeTitleDisplayMode = .automatic
        favoritesVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let homeNav = UINavigationController(rootViewController: homeVC)
        let favoritesNav = UINavigationController(rootViewController: favoritesVC)
        
        homeNav.tabBarItem = createNavBarItem("Home", "tv", 1)
        favoritesNav.tabBarItem = createNavBarItem("Favorites", "arrow.down.heart.fill", 2)
        
        for nav in [homeNav, favoritesNav] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers(
            [homeNav, favoritesNav],
            animated: true
        )
    }
    
    private func createNavBarItem(_ title: String, _ imageName: String, _ tag: Int) -> UITabBarItem {
        return UITabBarItem(
            title: title,
            image: UIImage(systemName: imageName),
            tag: tag)
    }


}

