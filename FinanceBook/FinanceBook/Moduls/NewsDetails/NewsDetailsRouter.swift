//
//  NewsDetailsRouter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

protocol INewsDetailsRouter: AnyObject {
    func showAlert(_ title: String)
}

final class NewsDetailsRouter {
    
    weak var controller: UIViewController?
}

extension NewsDetailsRouter: INewsDetailsRouter {
    
    func showAlert(_ title: String) {
        let alert = AlertAssembly.createAlert(title)
        self.controller?.present(alert, animated: true)
    }
}
