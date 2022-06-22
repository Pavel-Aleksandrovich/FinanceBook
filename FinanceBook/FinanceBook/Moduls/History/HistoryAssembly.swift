//
//  ChartAssembly.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

enum HistoryAssembly {
    
    static func build() -> UIViewController {
        
        let tableAdapter = HistoryTableAdapter()
        let presenter = HistoryPresenter()
        let dataManager = DataManager()
        let interactor = HistoryInteractor(presenter: presenter,
                                         dataManager: dataManager)
        let router = HistoryRouter()
        let controller = HistoryViewController(interactor: interactor,
                                             router: router,
                                             tableAdapter: tableAdapter)
        router.controller = controller
        
        return controller
    }
}
