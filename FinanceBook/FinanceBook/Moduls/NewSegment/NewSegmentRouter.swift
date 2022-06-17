//
//  NewSegmentRouter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

protocol INewSegmentRouter: AnyObject {
    func dismiss()
}

final class NewSegmentRouter {
    
    weak var controller: UIViewController?
}

extension NewSegmentRouter: INewSegmentRouter {
    
    func dismiss() {
        self.controller?.navigationController?.popToRootViewController(animated: true)
    }
}
