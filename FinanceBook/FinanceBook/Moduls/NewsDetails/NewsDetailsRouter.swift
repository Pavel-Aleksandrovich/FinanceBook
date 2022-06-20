//
//  NewsDetailsRouter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

protocol INewsDetailsRouter: AnyObject {
    func dismiss()
    func showErrorAlert(_ error: String)
}

final class NewsDetailsRouter {
    
    weak var controller: UIViewController?
}

extension NewsDetailsRouter: INewsDetailsRouter {
    
    func dismiss() {
        self.controller?.dismiss(animated: true)
    }
    
    func showErrorAlert(_ error: String) {
        let alert = AlertAssembly.createAlert(error)
        self.controller?.present(alert, animated: true)
    }
}
