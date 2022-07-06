//
//  HistoryView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit
import SnapKit

protocol IHistoryView: AnyObject {
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
    private let scrollView = UIScrollView()
    
    private var tableAdapter = HistoryTableAdapter()
    
    var onCellDeleteHandler: ((HistoryRequest) -> ())?
    
    init() {
        super.init(frame: .zero)
        self.setOnCellDeleteHandler()
        self.configAppearance()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HistoryView: IHistoryView {
    
    func setHistory(_ history: [HistoryViewModel]) {
        self.pieChartView.updateChart(history)
        self.tableAdapter.setHistory(history)
        self.tableView.reloadData()
    }
    
    func setImageViewState(_ state: Bool) {
        self.defaultView.isHidden = state
    }
}

// MARK: - Set Handlers
private extension HistoryView {
    
    func setOnCellDeleteHandler() {
        self.tableAdapter.onCellDeleteHandler = { [ weak self ] viewModel in
            self?.onCellDeleteHandler?(viewModel)
        }
    }
}

// MARK: - Config Appearance
private extension HistoryView {
    
    func configAppearance() {
        self.configView()
        self.configTableView()
        self.configScrollView()
    }
    
    func configView() {
        self.backgroundColor = .white
    }
    
    func configTableView() {
        self.tableView.allowsSelection = false
        self.tableView.showsVerticalScrollIndicator = false
        self.tableView.delegate = self.tableAdapter
        self.tableView.dataSource = self.tableAdapter
        self.tableView.register(HistoryCell.self,
                                forCellReuseIdentifier: HistoryCell.id)
    }
    
    func configScrollView() {
        self.scrollView.showsVerticalScrollIndicator = false
    }
}

// MARK: - Make Constraints
private extension HistoryView {
    
    func makeConstraints() {
        self.makeScrollViewConstraints()
        self.makeChartConstraints()
        self.makeTableViewConstraints()
        self.makeDefaultViewConstraints()
    }
    
    func makeScrollViewConstraints() {
        self.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func makeChartConstraints() {
        self.scrollView.addSubview(self.pieChartView)
        self.pieChartView.snp.makeConstraints { make in
            make.centerX.top.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(Constants.chartMultiplied)
            make.height.equalTo(self.pieChartView.snp.width)
        }
    }
    
    func makeTableViewConstraints() {
        self.scrollView.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.pieChartView.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(UIScreen.main.bounds.height - 200)
        }
    }
    
    func makeDefaultViewConstraints() {
        self.addSubview(self.defaultView)
        self.defaultView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
