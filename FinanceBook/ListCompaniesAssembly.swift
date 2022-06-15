//
//  ListCompaniesAssembly.swift
//  Homework-10
//
//  Created by pavel mishanin on 08.06.2022.
//

import UIKit

enum ListCompaniesAssembly {
    
    static func build() -> UIViewController {
        
        let tableAdapter = ListCompaniesTableAdapter()
        let presenter = ListCompaniesPresenter()
//        let dataManager = DataManager()
        let interactor = ListCompaniesInteractor(presenter: presenter)
        let router = ListCompaniesRouter()
        let controller = ListCompaniesViewController(interactor: interactor,
                                                     router: router,
                                                     tableAdapter: tableAdapter)
        router.controller = controller
        
        return controller
    }
}
