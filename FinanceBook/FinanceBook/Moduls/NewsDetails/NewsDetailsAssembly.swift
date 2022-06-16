//
//  NewsDetailsAssembly.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

enum NewsDetailsAssembly {
    
    static func build(article: Article) -> UIViewController {
        
        let presenter = NewsDetailsPresenter()
        let dataManager = DataManager()
        let interactor = NewsDetailsInteractor(presenter: presenter,
                                               dataManager: dataManager,
                                               article: article)
        let router = NewsDetailsRouter()
        let controller = NewsDetailsViewController(interactor: interactor,
                                                   router: router)
        router.controller = controller
        
        return controller
    }
}
