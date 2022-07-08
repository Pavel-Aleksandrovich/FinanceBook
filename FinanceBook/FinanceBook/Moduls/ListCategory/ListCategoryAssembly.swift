//
//  CategoryAssembly.swift
//  FinanceBook
//
//  Created by pavel mishanin on 06.07.2022.
//

import UIKit

enum ListCategoryAssembly {
    
    static func build(delegate: ListCategoryViewControllerDelegate) -> UIViewController {
        
        let presenter = ListCategoryPresenter()
        let interactor = ListCategoryInteractor(presenter: presenter)
        let router = ListCategoryRouter()
        let controller = ListCategoryViewController(interactor: interactor,
                                                    router: router,
                                                    delegate: delegate)
        
        return controller
    }
}
