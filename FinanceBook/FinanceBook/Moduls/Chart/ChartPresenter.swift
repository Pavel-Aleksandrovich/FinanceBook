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
    func showSuccess()
    func setSegments(_ segment: [Segment])
    func setCharts(_ chart: [ChartDTO])
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
//            self.controller?.showError(error.localizedDescription)
        }
    }
    
    func showSuccess() {
        DispatchQueue.main.async {
//            self.controller?.showSuccess()
        }
    }
    
    func setSegments(_ segment: [Segment]) {
        DispatchQueue.main.async {
//            self.tableAdapter?.setSegments(segment)
            self.view?.setSegments(segment)
        }
    }
    
    func setCharts(_ chart: [ChartDTO]) {
        DispatchQueue.main.async {
            self.tableAdapter?.setCharts(chart)
            print(chart.count)
        }
    }
}
