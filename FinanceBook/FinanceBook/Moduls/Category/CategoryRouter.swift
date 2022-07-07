//
//  CategoryRouter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 06.07.2022.
//

import UIKit

protocol ICategoryRouter: AnyObject {
    func setupViewController(_ controller: UIViewController)
    func popToRoot()
}

final class CategoryRouter {
    
    private weak var controller: UIViewController?
}

extension CategoryRouter: ICategoryRouter {
    
    func setupViewController(_ controller: UIViewController) {
        self.controller = controller
    }
    
    func popToRoot() {
        self.controller?.navigationController?.popViewController(animated: true)
    }
}
