//
//  ChartPresenter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import Foundation

protocol IHistoryPresenter: AnyObject {
    func onViewAttached(controller: IHistoryViewController,
                        view: IHistoryView)
    func showError(_ error: Error)
    func setHistory(_ history: [HistoryResponse])
}

final class HistoryPresenter {
    
    private weak var view: IHistoryView?
    private weak var controller: IHistoryViewController?
    
    private let mainQueue = DispatchQueue.main
}

extension HistoryPresenter: IHistoryPresenter {
    
    func onViewAttached(controller: IHistoryViewController,
                        view: IHistoryView) {
        self.controller = controller
        self.view = view
    }
    
    func showError(_ error: Error) {
        self.mainQueue.async {
            self.controller?.showError(error.localizedDescription)
        }
    }
    
    func setHistory(_ history: [HistoryResponse]) {
        let historyViewModel = self.getViewModel(from: history)
        
        self.mainQueue.async {
            self.view?.setImageViewState(!historyViewModel.isEmpty)
            self.view?.setHistory(historyViewModel)
        }
    }
}

private extension HistoryPresenter {
    
    func getViewModel(from array: [HistoryResponse]) -> [HistoryViewModel] {
        
        array.map { HistoryViewModel(history: $0,
                                     transaction: $0.transaction.map { TransactionTypeViewModel(transaction: $0) } ) }
    }
}
