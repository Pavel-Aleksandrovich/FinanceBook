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
}

final class ChartInteractor {
    
    private let presenter: IChartPresenter
    
    init(presenter: IChartPresenter) {
        self.presenter = presenter
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
        let segments = [
            Segment(color: #colorLiteral(red: 1.0, green: 0.121568627, blue: 0.28627451, alpha: 1.0), name: "Red",        value: 57.56, date: Date()),
            Segment(color: #colorLiteral(red: 1.0, green: 0.541176471, blue: 0.0, alpha: 1.0), name: "Orange",     value: 30, date: Date()),
            Segment(color: #colorLiteral(red: 0.478431373, green: 0.423529412, blue: 1.0, alpha: 1.0), name: "Purple",     value: 27, date: Date()),
            Segment(color: #colorLiteral(red: 0.0, green: 0.870588235, blue: 1.0, alpha: 1.0), name: "Light Blue", value: 40, date: Date()),
            Segment(color: #colorLiteral(red: 0.392156863, green: 0.945098039, blue: 0.717647059, alpha: 1.0), name: "Green",      value: 25, date: Date()),
            Segment(color: #colorLiteral(red: 0.0, green: 0.392156863, blue: 1.0, alpha: 1.0), name: "Blue",       value: 38, date: Date()),
            Segment(color: #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), name: "Green",       value: 207, date: Date())
        ]
        self.presenter.setSegments(segments)
    }
}
