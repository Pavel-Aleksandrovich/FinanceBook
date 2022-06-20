//
//  ChartRouter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

protocol IChartRouter: AnyObject {
    func showAddSegmentModul()
    func showErrorAlert(_ error: String)
}

final class ChartRouter {
    
    weak var controller: UIViewController?
}

extension ChartRouter: IChartRouter {
    
    func showAddSegmentModul() {
        let vc = NewSegmentAssembly.build()
        self.controller?.navigationController?.pushViewController(vc,
                                                                  animated: true)
    }
    
    func showErrorAlert(_ error: String) {
        let alert = AlertAssembly.createAlert(error)
        self.controller?.present(alert, animated: true)
    }
}
