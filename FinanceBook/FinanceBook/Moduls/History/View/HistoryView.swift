//
//  ChartView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit
import SnapKit

protocol IHistoryView: AnyObject {
    func getTableView() -> UITableView
    func setCharts(_ chart: [HistoryViewModel])
}

final class HistoryView: UIView {
    
    private enum Constants {
        static let chartMultiplied = 0.8
    }
        
    private let pieChartView = HistoryChart()
    private let tableView = UITableView()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.tableView.allowsSelection = false
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(HistoryCell.self,
                                 forCellReuseIdentifier: HistoryCell.id)
        self.makeChartConstraints()
        self.makeTableViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HistoryView: IHistoryView {
    
    func getTableView() -> UITableView {
        self.tableView
    }
    
    func setCharts(_ chart: [HistoryViewModel]) {
        self.pieChartView.updateChart(chart)
        print(chart.count)
    }
}

private extension HistoryView {
    
    func makeChartConstraints() {
        self.addSubview(self.pieChartView)
        self.pieChartView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.width.equalTo(self.snp.width).multipliedBy(Constants.chartMultiplied)
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