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
    func setTitleForDateLabel(dateInterval: DateCollectionAdapter.DateType)
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
    
    //MARK: - TO DO
    //if historyViewModel.isEmpty { showEmptyState() } else { showContent }
    func setHistory(_ history: [HistoryResponse]) {
        let historyViewModel = self.getViewModel(from: history)
        
        self.mainQueue.async {
            self.view?.setImageViewState(!historyViewModel.isEmpty)
            self.view?.setHistory(historyViewModel)
        }
    }
    
    func setTitleForDateLabel(dateInterval: DateCollectionAdapter.DateType) {
        print("presenter")
        switch dateInterval {
        case .day:
            print("day")
        case .week:
            print("week")
        case .month:
            print("month")
        case .year:
            print("year")
        case .all:
            print("all")
        }
    }
}

private extension HistoryPresenter {
    
    //MARK: - TO DO
    //move to coverter. Create new class - Converter() / Maper()
    // возможно сделать func конвертер во viewModel?
    
    func getViewModel(from array: [HistoryResponse]) -> [HistoryViewModel] {
        
        array.map { HistoryViewModel(history: $0,
                                     transaction: $0.transaction.map { TransactionTypeViewModel(transaction: $0) } ) }
    }
}
