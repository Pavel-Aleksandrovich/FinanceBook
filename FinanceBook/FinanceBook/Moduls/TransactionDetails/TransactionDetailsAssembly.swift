//
//  NewSegmentAssembly.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

enum TransactionDetailsAssembly {
    
    static func build() -> UIViewController {
        
        let presenter = TransactionDetailsPresenter()
        let coreData = CoreDataStorage.shared
        let dataManager = HistoryDataManager(coreDataStorage: coreData)
        let validator = TransactionDetailsValidator()
        let interactor = TransactionDetailsInteractor(presenter: presenter,
                                                      dataManager: dataManager,
                                                      validator: validator)
        let router = TransactionDetailsRouter()
        let controller = TransactionDetailsViewController(interactor: interactor,
                                                          router: router)
        router.controller = controller
        
        return controller
    }
}
