//
//  HistoryView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit
import SnapKit

protocol IHistoryView: AnyObject {
    func getTableView() -> UITableView
    func setHistory(_ chart: [HistoryViewModel])
    func setImageViewState(_ state: Bool)
}

final class HistoryView: UIView {
    
    private enum Constants {
        static let chartMultiplied = 0.8
    }
    
    private let pieChartView = HistoryChart()
    private let tableView = UITableView()
    private let defaultView = DefaultHistoryView()
    
    init() {
        super.init(frame: .zero)
        self.configAppearance()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HistoryView: IHistoryView {
    
    func getTableView() -> UITableView {
        self.tableView
    }
    
    func setHistory(_ history: [HistoryViewModel]) {
        self.pieChartView.updateChart(history)
    }
    
    func setImageViewState(_ state: Bool) {
        self.defaultView.isHidden = state
    }
}

private extension HistoryView {
    
    func configAppearance() {
        self.configView()
        self.configTableView()
    }
    
    func configView() {
        self.backgroundColor = .white
    }
    
    func configTableView() {
        self.tableView.allowsSelection = false
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.register(HistoryCell.self,
                                forCellReuseIdentifier: HistoryCell.id)
    }
    
    func makeConstraints() {
        self.makeChartConstraints()
        self.makeTableViewConstraints()
        self.makeDefaultViewConstraints()
    }
    
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
    
    func makeDefaultViewConstraints() {
        self.addSubview(self.defaultView)
        self.defaultView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
