//
//  TabBarAssembly.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit

final class TabBarAssembly: UITabBarController {
    
    private enum Constants {
        static let HistoryImageName = "chart.pie"
        static let HistoryItemTitle = "History"
        static let HistoryTag = 0
        
        static let ListNewsImageName = "magazine"
        static let ListNewsItemTitle = "News"
        static let ListNewsTag = 1
        
        static let FavoriteNewsImageName = "bookmark"
        static let FavoriteNewsItemTitle = "Favorite"
        static let FavoriteNewsTag = 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [self.createHistoryViewController(),
                                self.createListNewsViewController(),
                                self.createFavoriteNewsViewController()]
        self.tabBar.tintColor = MainAttributs.color
    }
}

private extension TabBarAssembly {
    
    func createHistoryViewController() -> UIViewController {
        let vc = HistoryAssembly.build()
        let image = UIImage(systemName: Constants.HistoryImageName)
        vc.tabBarItem = UITabBarItem(title: Constants.HistoryItemTitle,
                                     image: image,
                                     tag: Constants.HistoryTag)
        
        return UINavigationController(rootViewController: vc)
    }
    
    func createListNewsViewController() -> UIViewController {
        let vc = ListNewsAssembly.build()
        let image = UIImage(systemName: Constants.ListNewsImageName)
        vc.tabBarItem = UITabBarItem(title: Constants.ListNewsItemTitle,
                                     image: image,
                                     tag: Constants.ListNewsTag)
        
        return UINavigationController(rootViewController: vc)
    }
    
    func createFavoriteNewsViewController() -> UIViewController {
        let vc = FavoriteNewsAssembly.build()
        let image = UIImage(systemName: Constants.FavoriteNewsImageName)
        vc.tabBarItem = UITabBarItem(title: Constants.FavoriteNewsItemTitle,
                                     image: image,
                                     tag: Constants.FavoriteNewsTag)
        
        return UINavigationController(rootViewController: vc)
    }
}
