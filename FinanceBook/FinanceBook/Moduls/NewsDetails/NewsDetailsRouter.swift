//
//  NewsDetailsRouter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

protocol INewsDetailsRouter: AnyObject {
    func setupViewController(_ controller: UIViewController)
    func showAlert(_ title: String)
}

final class NewsDetailsRouter {
    
    private weak var controller: UIViewController?
}

extension NewsDetailsRouter: INewsDetailsRouter {
    
    func setupViewController(_ controller: UIViewController) {
        self.controller = controller
    }
    
    func showAlert(_ title: String) {
        let alert = AlertAssembly.createAlert(title)
        self.controller?.present(alert, animated: true)
    }
}
