//
//  FavoriteNewsAssembly.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit

enum FavoriteNewsAssembly {
    
    static func build() -> UIViewController {
        
        let tableAdapter = FavoriteNewsTableAdapter()
        let presenter = FavoriteNewsPresenter()
        let coreData = CoreDataStorage.shared
        let dataManager = NewsDataManager(coreDataStorage: coreData)
        let interactor = FavoriteNewsInteractor(presenter: presenter,
                                                dataManager: dataManager)
        let router = FavoriteNewsRouter()
        let controller = FavoriteNewsViewController(interactor: interactor,
                                                    router: router,
                                                    tableAdapter: tableAdapter)
        router.controller = controller
        
        return controller
    }
}
