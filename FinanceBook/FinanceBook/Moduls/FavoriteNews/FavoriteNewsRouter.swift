//
//  FavoriteNewsRouter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit

protocol IFavoriteNewsRouter: AnyObject {
    func showAlert(_ title: String)
}

final class FavoriteNewsRouter {
    
    weak var controller: UIViewController?
}

extension FavoriteNewsRouter: IFavoriteNewsRouter {
    
    func showAlert(_ title: String) {
        let alert = AlertAssembly.createAlert(title)
        self.controller?.present(alert, animated: true)
    }
}
