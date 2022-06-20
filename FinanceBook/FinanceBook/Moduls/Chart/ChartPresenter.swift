//
//  ChartPresenter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import Foundation

protocol IChartPresenter: AnyObject {
    func onViewAttached(controller: IChartViewController,
                        view: IChartView,
                        tableAdapter: IChartTableAdapter)
    func showError(_ error: Error)
    func setCharts(_ chart: [ChartDTOResponse])
}

final class ChartPresenter {
    
    private weak var view: IChartView?
    private weak var controller: IChartViewController?
    private weak var tableAdapter: IChartTableAdapter?
}

extension ChartPresenter: IChartPresenter {
    
    func onViewAttached(controller: IChartViewController,
                        view: IChartView,
                        tableAdapter: IChartTableAdapter) {
        self.controller = controller
        self.view = view
        self.tableAdapter = tableAdapter
        
        self.tableAdapter?.tableView = self.view?.getTableView()
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            self.controller?.showError(error.localizedDescription)
        }
    }
    
    func setCharts(_ chart: [ChartDTOResponse]) {
        let chartViewModel = self.getViewModel(from: chart)
        
        DispatchQueue.main.async {
            self.tableAdapter?.setCharts(chartViewModel)
            self.view?.setCharts(chartViewModel)
        }
    }
}

private extension ChartPresenter {
    
    func getViewModel(from array: [ChartDTOResponse]) -> [ChartViewModelResponse] {
        
        array.map { ChartViewModelResponse(chart: $0,
                                           segment: $0.segment.map { SegmentViewModelResponse(segment: $0) } ) }
    }
}
