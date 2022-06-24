//
//  HistoryRouter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

protocol IHistoryRouter: AnyObject {
    func showAddTransactionModul()
    func showAlert(_ title: String)
}

final class HistoryRouter {
    
    weak var controller: UIViewController?
}

extension HistoryRouter: IHistoryRouter {
    
    func showAddTransactionModul() {
        let vc = TransactionDetailsAssembly.build()
        self.controller?.navigationController?.pushViewController(vc,
                                                                  animated: true)
    }
    
    func showAlert(_ title: String) {
        let alert = AlertAssembly.createAlert(title)
        self.controller?.present(alert, animated: true)
    }
}
