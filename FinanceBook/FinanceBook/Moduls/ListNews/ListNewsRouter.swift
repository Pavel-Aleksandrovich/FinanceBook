//
//  ListNewsRouter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

protocol IListNewsRouter: AnyObject {
    func showArticleDetails(_ article: NewsRequest)
    func showAlert(_ title: String)
    func showCountryAlert(complition: @escaping(Country) -> ())
}

final class ListNewsRouter {
    
    weak var controller: UIViewController?
}

extension ListNewsRouter: IListNewsRouter {
    
    func showArticleDetails(_ article: NewsRequest) {
        let vc = NewsDetailsAssembly.build(article: article)
        self.controller?.present(vc, animated: false)
    }
    
    func showCountryAlert(complition: @escaping(Country) -> ()) {
        let alert = AlertAssembly.createCountryAlert { country in
            complition(country)
        }
        self.controller?.present(alert, animated: true)
    }
    
    func showAlert(_ title: String) {
        let alert = AlertAssembly.createAlert(title)
        self.controller?.present(alert, animated: true)
    }
}
