//
//  NewSegmentRouter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

protocol INewSegmentRouter: AnyObject {
    func popToRoot()
    func showErrorAlert(_ error: String)
    func showSuccessAlert(complition: @escaping() -> ())
}

final class NewSegmentRouter {
    
    weak var controller: UIViewController?
}

extension NewSegmentRouter: INewSegmentRouter {
    
    func popToRoot() {
        self.controller?.navigationController?.popToRootViewController(animated: true)
    }
    
    func showErrorAlert(_ error: String) {
        let alert = AlertAssembly.createErrorAlert(error)
        self.controller?.present(alert, animated: true)
    }
    
    func showSuccessAlert(complition: @escaping() -> ()) {
        let alert = AlertAssembly.createSuccessAlert {
            complition()
        }
        self.controller?.present(alert, animated: true)
    }
}
