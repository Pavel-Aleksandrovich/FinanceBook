//
//  ChartRouter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

protocol IHistoryRouter: AnyObject {
    func showAddSegmentModul()
    func showErrorAlert(_ error: String)
}

final class HistoryRouter {
    
    weak var controller: UIViewController?
}

extension HistoryRouter: IHistoryRouter {
    
    func showAddSegmentModul() {
        let vc = TransactionDetailsAssembly.build()
        self.controller?.navigationController?.pushViewController(vc,
                                                                  animated: true)
    }
    
    func showErrorAlert(_ error: String) {
        let alert = AlertAssembly.createAlert(error)
        self.controller?.present(alert, animated: true)
    }
}
