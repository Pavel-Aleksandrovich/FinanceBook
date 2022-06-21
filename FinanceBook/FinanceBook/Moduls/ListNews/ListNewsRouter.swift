//
//  ListNewsRouter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

protocol IListNewsRouter: AnyObject {
    func showArticleDetails(_ article: NewsRequest)
    func showErrorAlert(_ error: String)
    func showLanguageAlert(complition: @escaping(String) -> ())
}

final class ListNewsRouter {
    
    weak var controller: UIViewController?
}

extension ListNewsRouter: IListNewsRouter {
    
    func showArticleDetails(_ article: NewsRequest) {
        let vc = NewsDetailsAssembly.build(article: article)
        self.controller?.present(vc, animated: true)
    }
    
    func showLanguageAlert(complition: @escaping(String) -> ()) {
        let alert = AlertAssembly.createLanguageAlert { language in
            complition(language)
        }
        self.controller?.present(alert, animated: true)
    }
    
    func showErrorAlert(_ error: String) {
        let alert = AlertAssembly.createAlert(error)
        self.controller?.present(alert, animated: true)
    }
}
