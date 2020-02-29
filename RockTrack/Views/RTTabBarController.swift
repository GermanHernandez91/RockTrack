//
//  RTTabBarController.swift
//  RockTrack
//
//  Created by German Hernandez on 29/02/2020.
//  Copyright © 2020 German Hernandez. All rights reserved.
//

import UIKit

class RTTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [createTrackListNC(), createFavoriteListNC()]
    }
    
    
    // MARK: - Methods
        
    func createTrackListNC() -> UINavigationController {
        let trackListVC = TrackListVC()
        trackListVC.title = "Rock Tracks"
        trackListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        return UINavigationController(rootViewController: trackListVC)
    }
    
    
    func createFavoriteListNC() -> UINavigationController {
        let favoriteListVC = FavoriteListVC()
        favoriteListVC.title = "Favorite tracks"
        favoriteListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        
        return UINavigationController(rootViewController: favoriteListVC)
    }
}
