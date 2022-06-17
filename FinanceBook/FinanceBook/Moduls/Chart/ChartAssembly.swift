//
//  ChartAssembly.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

enum ChartAssembly {
    
    static func build() -> UIViewController {
        
        let tableAdapter = ChartTableAdapter()
        let presenter = ChartPresenter()
        let dataManager = DataManager()
        let interactor = ChartInteractor(presenter: presenter,
                                         dataManager: dataManager)
        let router = ChartRouter()
        let controller = ChartViewController(interactor: interactor,
                                             router: router,
                                             tableAdapter: tableAdapter)
        router.controller = controller
        
        return controller
    }
}
