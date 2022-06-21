//
//  FavoriteNewsRouter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit

protocol IFavoriteNewsRouter: AnyObject {
    func showArticleDetails(_ article: FavoriteNewsResponse)
    func showAlert(complition: @escaping() -> ())
    func showErrorAlert(_ error: String)
}

final class FavoriteNewsRouter {
    
    weak var controller: UIViewController?
}

extension FavoriteNewsRouter: IFavoriteNewsRouter {
    
    func showArticleDetails(_ article: FavoriteNewsResponse) {
        print(#function)
    }
    
    func showAlert(complition: @escaping() -> ()) {
    }
    
    func showErrorAlert(_ error: String) {
        let alert = AlertAssembly.createAlert(error)
        self.controller?.present(alert, animated: true)
    }
}
