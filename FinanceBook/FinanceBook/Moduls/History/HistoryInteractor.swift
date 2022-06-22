//
//  ChartInteractor.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import Foundation

protocol IHistoryInteractor: AnyObject {
    func onViewAttached(controller: IHistoryViewController,
                        view: IHistoryView,
                        tableAdapter: IHistoryTableAdapter)
    func loadData()
    func deleteSegment(_ viewModel: HistoryRequest)
}

final class HistoryInteractor {
    
    private let presenter: IHistoryPresenter
    private let dataManager: IHistoryDataManager
    
    init(presenter: IHistoryPresenter, dataManager: IHistoryDataManager) {
        self.presenter = presenter
        self.dataManager = dataManager
    }
}

extension HistoryInteractor: IHistoryInteractor {
    
    func onViewAttached(controller: IHistoryViewController,
                        view: IHistoryView,
                        tableAdapter: IHistoryTableAdapter) {
        self.presenter.onViewAttached(controller: controller,
                                      view: view,
                                      tableAdapter: tableAdapter)
    }
    
    func loadData() {
        self.dataManager.getListSegments { [ weak self ] result in
            switch result {
            case .success(let model):
                self?.presenter.setCharts(model)
            case .failure(let error):
                self?.presenter.showError(error)
            }
        }
    }
    
    func deleteSegment(_ viewModel: HistoryRequest) {
        if viewModel.transactionTypeCount == 1 {
            self.deleteChartBy(id: viewModel.id)
        } else {
            self.deleteSegmentBy(id: viewModel.idSegment)
        }
    }
}

private extension HistoryInteractor {
    
    func deleteSegmentBy(id: UUID) {
        self.dataManager.deleteSegmentBy(id: id) { [ weak self ] result in
            switch result {
            case .success():
                self?.loadData()
            case .failure(let error):
                self?.presenter.showError(error)
            }
        }
    }
    
    func deleteChartBy(id: UUID) {
        self.dataManager.deleteChartBy(id: id) { [ weak self ] result in
            switch result {
            case .success():
                self?.loadData()
            case .failure(let error):
                self?.presenter.showError(error)
            }
        }
    }
}
