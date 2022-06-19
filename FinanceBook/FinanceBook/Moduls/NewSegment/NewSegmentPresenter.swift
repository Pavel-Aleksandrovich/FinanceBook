//
//  NewSegmentPresenter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import Foundation

protocol INewSegmentPresenter: AnyObject {
    func onViewAttached(controller: INewSegmentViewController,
                        view: INewSegmentView)
    func showError(_ error: Error)
    func showSuccess()
}

final class NewSegmentPresenter {
    
    private weak var view: INewSegmentView?
    private weak var controller: INewSegmentViewController?
}

extension NewSegmentPresenter: INewSegmentPresenter {
    
    func onViewAttached(controller: INewSegmentViewController,
                        view: INewSegmentView) {
        self.controller = controller
        self.view = view
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            self.controller?.showError(error.localizedDescription)
        }
    }
    
    func showSuccess() {
        DispatchQueue.main.async {
            self.controller?.showSuccess()
        }
    }
}
