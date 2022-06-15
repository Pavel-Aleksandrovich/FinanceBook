//
//  NewsDetailsRouter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

protocol INewsDetailsRouter: AnyObject {
    func dismiss()
}

final class NewsDetailsRouter {
    
    weak var controller: UIViewController?
}

extension NewsDetailsRouter: INewsDetailsRouter {
    
    func dismiss() {
        self.controller?.dismiss(animated: true)
    }
}
