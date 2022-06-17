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
    func createChart()
    func loadData()
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
    
    func createChart() {
        let segments = Segment(name: "tramp", color: .red, amount: 782, date: Date())
        
        let chart = ChartRequest(segments: segments)
        self.dataManager.create(segment: chart) { [ weak self ] result in
            switch result {
            case .success():
                print("success")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadData() {
//        let segments = [Segment(name: "name", color: .orange, amount: 50, date: Date())]
//        self.presenter.setSegments(segments)
        
        self.dataManager.getListSegments { [ weak self ] result in
            switch result {
            case .success(let model):
                self?.presenter.setCharts(model)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct ChartRequest {
    let id: UUID
    let idSegment: UUID
    let name: String
    let color: Data
    let amount: Int
    let date: Date
    
    init(segments: Segment) {
        self.id = segments.id
        self.idSegment = segments.segment.id
        self.name = segments.name
        self.color = ColorConverter.toData(fromColor: segments.color) ?? Data()
        self.amount = segments.segment.amount
        self.date = segments.segment.date
    }
}
