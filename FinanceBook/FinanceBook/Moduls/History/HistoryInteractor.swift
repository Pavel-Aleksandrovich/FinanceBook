//
//  ChartInteractor.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import Foundation

protocol IHistoryInteractor: AnyObject {
    func onViewAttached(controller: IHistoryViewController,
                        view: IHistoryView)
    func loadData()
    func deleteTransaction(_ viewModel: HistoryRequest)
}

final class HistoryInteractor {
    
    private let presenter: IHistoryPresenter
    private let dataManager: IHistoryDataManager
    
    init(presenter: IHistoryPresenter,
         dataManager: IHistoryDataManager) {
        self.presenter = presenter
        self.dataManager = dataManager
    }
}

extension HistoryInteractor: IHistoryInteractor {
    
    func onViewAttached(controller: IHistoryViewController,
                        view: IHistoryView) {
        self.presenter.onViewAttached(controller: controller,
                                      view: view)
    }
    
    func loadData() {
        self.dataManager.getHistory { [ weak self ] result in
            switch result {
            case .success(let historyResponse):
                self?.presenter.setHistory(historyResponse)
            case .failure(let error):
                self?.presenter.showError(error)
            }
        }
    }
    
    func deleteTransaction(_ viewModel: HistoryRequest) {
        if viewModel.transactionCount == 1 {
            self.deleteHistoryBy(id: viewModel.id)
        } else {
            self.deleteTransactionBy(id: viewModel.idSegment)
        }
    }
}

private extension HistoryInteractor {
    
    func deleteTransactionBy(id: UUID) {
        self.dataManager.deleteTransactionBy(id: id) { [ weak self ] result in
            switch result {
            case .success():
                self?.loadData()
            case .failure(let error):
                self?.presenter.showError(error)
            }
        }
    }
    
    func deleteHistoryBy(id: UUID) {
        self.dataManager.deleteHistoryBy(id: id) { [ weak self ] result in
            switch result {
            case .success():
                self?.loadData()
            case .failure(let error):
                self?.presenter.showError(error)
            }
        }
    }
}
