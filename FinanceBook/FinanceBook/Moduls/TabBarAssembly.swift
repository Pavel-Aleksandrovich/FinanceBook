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
        self.viewControllers = [self.createHistoryViewController(),
                                self.createListNewsViewController(),
                                self.createFavoriteNewsViewController()]
        self.tabBar.tintColor = MainAttributs.color
    }
}

private extension TabBarAssembly {
    
    func createListNewsViewController() -> UIViewController {
        let vc = ListNewsAssembly.build()
        let image = UIImage(systemName: "magazine")
        vc.tabBarItem = UITabBarItem(title: "News",
                                     image: image,
                                     tag: 1)
        
        return UINavigationController(rootViewController: vc)
    }
    
    func createFavoriteNewsViewController() -> UIViewController {
        let vc = FavoriteNewsAssembly.build()
        let image = UIImage(systemName: "bookmark")
        vc.tabBarItem = UITabBarItem(title: "Favorite",
                                     image: image,
                                     tag: 2)
        
        return UINavigationController(rootViewController: vc)
    }
    
    func createHistoryViewController() -> UIViewController {
        let vc = HistoryAssembly.build()
        let image = UIImage(systemName: "chart.pie")
        vc.tabBarItem = UITabBarItem(title: "History",
                                     image: image,
                                     tag: 0)
        
        return UINavigationController(rootViewController: vc)
    }
}
