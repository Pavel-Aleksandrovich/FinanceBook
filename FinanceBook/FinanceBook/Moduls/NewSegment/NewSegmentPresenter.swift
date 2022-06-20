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
    func setValidateSuccess(_ result: ValidateSuccess)
    func setValidateError(_ result: ValidateError)
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
    
    func setValidateSuccess(_ result: ValidateSuccess) {
        switch result {
        case .name:
            self.view?.updateSaveButtonState(.off)
        case .amount:
            self.view?.updateSaveButtonState(.off)
        case .date:
            self.view?.updateSaveButtonState(.off)
        case .all:
            self.view?.updateSaveButtonState(.on)
        }
    }
    
    func setValidateError(_ result: ValidateError) {
        switch result {
        case .name:
            self.view?.showErrorCategoryNameTextField()
        case .amount:
            self.view?.showErrorNumberTextField()
        case .date:
            self.view?.showErrorDateTextField()
        }
    }
}
