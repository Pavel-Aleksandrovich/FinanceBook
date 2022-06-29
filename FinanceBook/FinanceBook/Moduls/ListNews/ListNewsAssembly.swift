//
//  ListNewsAssembly.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

enum ListNewsAssembly {
    
    static func build() -> UIViewController {
        
        let tableAdapter = ListNewsTableAdapter()
        let presenter = ListNewsPresenter()
        let networkManager = NewsNetworkManager()
        let internetChecker = InternetChecker()
        let interactor = ListNewsInteractor(presenter: presenter,
                                            networkManager: networkManager,
                                            internetChecker: internetChecker)
        let router = ListNewsRouter()
        let collectionAdapter = CollectionViewAdapter()
        let controller = ListNewsViewController(interactor: interactor,
                                                router: router,
                                                tableAdapter: tableAdapter,
                                                collectionAdapter: collectionAdapter)
        
        return controller
    }
}
