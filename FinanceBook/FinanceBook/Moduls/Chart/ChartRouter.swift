//
//  ChartRouter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

protocol IChartRouter: AnyObject {
    func showAddSegmentModul()
}

final class ChartRouter {
    
    weak var controller: UIViewController?
}

extension ChartRouter: IChartRouter {
    
    func showAddSegmentModul() {
        let vc = NewSegmentAssembly.build()
//        let nav = UINavigationController(rootViewController: vc)
        self.controller?.navigationController?.pushViewController(vc, animated: true)
    }
}
