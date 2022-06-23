//
//  NewsDetailsAssembly.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

enum NewsDetailsAssembly {
    
    static func build(article: NewsRequest) -> UIViewController {
        
        let presenter = NewsDetailsPresenter()
        let coreData = CoreDataStorage.shared
        let dataManager = NewsDataManager(coreDataStorage: coreData)
        let networkManager = NewsNetworkManager()
        let interactor = NewsDetailsInteractor(presenter: presenter,
                                               dataManager: dataManager,
                                               networkManager: networkManager,
                                               article: article)
        let router = NewsDetailsRouter()
        let controller = NewsDetailsViewController(interactor: interactor,
                                                   router: router)
        router.controller = controller
        
        return controller
    }
}
