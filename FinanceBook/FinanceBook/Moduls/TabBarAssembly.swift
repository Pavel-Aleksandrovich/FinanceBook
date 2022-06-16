//
//  TabBarAssembly.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit

final class TabBarAssembly: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [self.createListNewsViewController(),
                                self.createFavoriteNewsViewController()]
    }
}

private extension TabBarAssembly {
    
    func createListNewsViewController() -> UIViewController {
        let listNewsViewController = ListNewsAssembly.build()
        let image = UIImage(systemName: "magazine")
        listNewsViewController.tabBarItem = UITabBarItem(title: "News",
                                                         image: image,
                                                         tag: 0)
        
        return UINavigationController(rootViewController: listNewsViewController)
    }
    
    func createFavoriteNewsViewController() -> UIViewController {
        let favoriteNewsViewController = FavoriteNewsAssembly.build()
        let image = UIImage(systemName: "bookmark")
        favoriteNewsViewController.tabBarItem = UITabBarItem(title: "Favorite",
                                                             image: image,
                                                             tag: 1)
        
        return UINavigationController(rootViewController: favoriteNewsViewController)
    }
}
