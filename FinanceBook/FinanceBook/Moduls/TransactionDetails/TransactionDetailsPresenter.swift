//
//  NewSegmentPresenter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import Foundation

protocol ITransactionDetailsPresenter: AnyObject {
    func onViewAttached(controller: ITransactionDetailsViewController,
                        view: ITransactionDetailsView)
    func showError(_ error: Error)
    func showSuccess()
    func setValidateSuccess(_ result: ValidateSuccess)
    func setValidateError(_ result: ValidateError)
}

final class TransactionDetailsPresenter {
    
    private weak var view: ITransactionDetailsView?
    private weak var controller: ITransactionDetailsViewController?
    
    private let mainQueue = DispatchQueue.main
}

extension TransactionDetailsPresenter: ITransactionDetailsPresenter {
    
    func onViewAttached(controller: ITransactionDetailsViewController,
                        view: ITransactionDetailsView) {
        self.controller = controller
        self.view = view
    }
    
    func showError(_ error: Error) {
        self.mainQueue.async {
            self.controller?.showError(error.localizedDescription)
        }
    }
    
    func showSuccess() {
        self.mainQueue.async {
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
