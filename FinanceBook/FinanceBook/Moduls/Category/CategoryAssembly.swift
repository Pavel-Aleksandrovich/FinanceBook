//
//  CategoryAssembly.swift
//  FinanceBook
//
//  Created by pavel mishanin on 06.07.2022.
//

import UIKit

enum CategoryAssembly {
    
    static func build(delegate: CategoryViewControllerDelegate) -> UIViewController {
        
        let presenter = CategoryPresenter()
        let interactor = CategoryInteractor(presenter: presenter)
        let router = CategoryRouter()
        let controller = CategoryViewController(interactor: interactor,
                                                router: router,
                                                delegate: delegate)
        
        return controller
    }
}
