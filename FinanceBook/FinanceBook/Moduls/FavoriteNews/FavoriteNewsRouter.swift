//
//  FavoriteNewsRouter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit

protocol IFavoriteNewsRouter: AnyObject {
    func showArticleDetails(_ article: Article)
    func showAlert(complition: @escaping() -> ())
    func showErrorAlert(_ error: String)
}

final class FavoriteNewsRouter {
    
    weak var controller: UIViewController?
}

extension FavoriteNewsRouter: IFavoriteNewsRouter {
    
    func showArticleDetails(_ article: Article) {
        print(#function)
    }
    
    func showAlert(complition: @escaping() -> ()) {
    }
    
    func showErrorAlert(_ error: String) {
    }
}
