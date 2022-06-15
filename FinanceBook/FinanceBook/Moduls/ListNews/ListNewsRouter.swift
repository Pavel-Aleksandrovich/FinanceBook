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
        print(24)
    }
    
    func showAlert(complition: @escaping() -> ()) {
    }
    
    func showErrorAlert(_ error: String) {
    }
}
