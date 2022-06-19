//
//  ChartInteractor.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import Foundation

protocol IChartInteractor: AnyObject {
    func onViewAttached(controller: IChartViewController,
                        view: IChartView,
                        tableAdapter: IChartTableAdapter)
    func loadData()
    func deleteSegment(_ segment: SegmentDTO, from chart: ChartDTO)
}

final class ChartInteractor {
    
    private let presenter: IChartPresenter
    private let dataManager: IChartDataManager
    
    init(presenter: IChartPresenter, dataManager: IChartDataManager) {
        self.presenter = presenter
        self.dataManager = dataManager
    }
}

extension ChartInteractor: IChartInteractor {
    
    func onViewAttached(controller: IChartViewController,
                        view: IChartView,
                        tableAdapter: IChartTableAdapter) {
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
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteSegment(_ segment: SegmentDTO, from chart: ChartDTO) {
        self.dataManager.deleteSegment(segment,
                                       from: chart) { [ weak self ] result in
            switch result {
            case .success():
                self?.loadData()
            case .failure(let error):
                print(error)
            }
        }
    }
}