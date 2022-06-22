//
//  ChartPresenter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import Foundation

protocol IHistoryPresenter: AnyObject {
    func onViewAttached(controller: IHistoryViewController,
                        view: IHistoryView,
                        tableAdapter: IHistoryTableAdapter)
    func showError(_ error: Error)
    func setCharts(_ chart: [HistoryResponse])
}

final class HistoryPresenter {
    
    private weak var view: IHistoryView?
    private weak var controller: IHistoryViewController?
    private weak var tableAdapter: IHistoryTableAdapter?
    
    private let mainQueue = DispatchQueue.main
}

extension HistoryPresenter: IHistoryPresenter {
    
    func onViewAttached(controller: IHistoryViewController,
                        view: IHistoryView,
                        tableAdapter: IHistoryTableAdapter) {
        self.controller = controller
        self.view = view
        self.tableAdapter = tableAdapter
        
        self.tableAdapter?.tableView = self.view?.getTableView()
    }
    
    func showError(_ error: Error) {
        self.mainQueue.async {
            self.controller?.showError(error.localizedDescription)
        }
    }
    
    func setCharts(_ chart: [HistoryResponse]) {
        let chartViewModel = self.getViewModel(from: chart)
        
        self.mainQueue.async {
            self.tableAdapter?.setCharts(chartViewModel)
            self.view?.setCharts(chartViewModel)
        }
    }
}

private extension HistoryPresenter {
    
    func getViewModel(from array: [HistoryResponse]) -> [HistoryViewModel] {
        
        array.map { HistoryViewModel(chart: $0,
                                           segment: $0.transactionType.map { TransactionTypeViewModel(segment: $0) } ) }
    }
}
