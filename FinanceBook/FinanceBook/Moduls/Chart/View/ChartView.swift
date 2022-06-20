//
//  ChartView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit
import SnapKit

protocol IChartView: AnyObject {
    func getTableView() -> UITableView
    func setCharts(_ chart: [ChartViewModelResponse])
}

final class ChartView: UIView {
    
    private let pieChartView = PieChart()
    private let tableView = UITableView()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.tableView.allowsSelection = false
        self.tableView.showsVerticalScrollIndicator = false
        
        self.makeChartConstraints()
        self.makeTableViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChartView: IChartView {
    
    func getTableView() -> UITableView {
        self.tableView
    }
    
    func setCharts(_ chart: [ChartViewModelResponse]) {
        self.pieChartView.updateChart(chart)
        print(chart.count)
    }
}

private extension ChartView {
    
    func makeChartConstraints() {
        self.addSubview(self.pieChartView)
        self.pieChartView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.width.equalTo(self.snp.width).multipliedBy(0.8)
            make.height.equalTo(self.pieChartView.snp.width)
        }
    }
    
    func makeTableViewConstraints() {
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.pieChartView.snp.bottom)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
}
