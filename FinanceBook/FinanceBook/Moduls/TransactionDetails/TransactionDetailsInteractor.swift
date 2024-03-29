//
//  NewSegmentInteractor.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import Foundation

protocol ITransactionDetailsInteractor: AnyObject {
    func onViewAttached(controller: ITransactionDetailsViewController,
                        view: ITransactionDetailsView)
    func createTransaction(_ viewModel: HistoryValidateRequest?)
    func checkTextFields(viewModel: HistoryValidateRequest?)
}

final class TransactionDetailsInteractor {
    
    private let presenter: ITransactionDetailsPresenter
    private let dataManager: IHistoryDataManager
    private let validator: ITransactionDetailsValidator
    
    init(presenter: ITransactionDetailsPresenter,
         dataManager: IHistoryDataManager,
         validator: ITransactionDetailsValidator) {
        self.presenter = presenter
        self.dataManager = dataManager
        self.validator = validator
    }
}

extension TransactionDetailsInteractor: ITransactionDetailsInteractor {
    
    func createTransaction(_ viewModel: HistoryValidateRequest?) {
        let result = self.validator.check(viewModel: viewModel) { [ weak self ] result in
            switch result {
            case .success(_): break
            case .error(let errorResult):
                self?.presenter.setValidateError(errorResult)
            }
        }
        
        if result == true {
            let chartRequest = TransactionRequest(viewModel: viewModel)
            guard let chartRequest = chartRequest else { return }
            print("46 - \(chartRequest.date)")
            self.save(transaction: chartRequest)
        } else {
            self.presenter.buttonIsEmpty()
        }
    }
    
    func checkTextFields(viewModel: HistoryValidateRequest?) {
        let _ = self.validator.check(viewModel: viewModel)
        { [ weak self ] result in
            switch result {
            case .success(let successResult):
                self?.presenter.setValidateSuccess(successResult)
            case .error(_): break
            }
        }
    }
    
    func onViewAttached(controller: ITransactionDetailsViewController,
                        view: ITransactionDetailsView) {
        self.presenter.onViewAttached(controller: controller,
                                      view: view)
    }
}

private extension TransactionDetailsInteractor {
    
    func save(transaction: TransactionRequest) {
        self.dataManager.create(transaction: transaction)
        { [ weak self ] result in
            switch result {
            case .success():
                self?.presenter.showSuccess()
            case .failure(let error):
                self?.presenter.showError(error)
            }
        }
    }
}
