//
//  ListNewsRouter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

protocol IListNewsRouter: AnyObject {
    func showArticleDetails(_ article: Article)
    func showAlert(complition: @escaping() -> ())
    func showErrorAlert(_ error: String)
}

final class ListNewsRouter {
    
    weak var controller: UIViewController?
}

extension ListNewsRouter: IListNewsRouter {
    
    func showArticleDetails(_ article: Article) {
        let vc = NewsDetailsAssembly.build(article: article)
        let nav = UINavigationController(rootViewController: vc)
        self.controller?.present(nav, animated: true)
    }
    
    func showAlert(complition: @escaping() -> ()) {
    }
    
    func showErrorAlert(_ error: String) {
    }
}
