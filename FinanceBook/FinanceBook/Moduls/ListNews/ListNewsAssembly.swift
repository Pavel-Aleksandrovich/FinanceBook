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
        let interactor = ListNewsInteractor(presenter: presenter)
        let router = ListNewsRouter()
        let controller = ListNewsViewController(interactor: interactor,
                                                router: router,
                                                tableAdapter: tableAdapter)
        router.controller = controller
        
        return controller
    }
}
