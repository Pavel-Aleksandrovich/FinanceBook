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
    func updateChart(segment: Segment)
    func setSegments(_ segment: [Segment])
}

final class ChartView: UIView {
    
    private let pieChartView = PieChart()
    private let tableView = UITableView()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        
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
    
    func updateChart(segment: Segment) {
        
        if pieChartView.segments.contains(where: { $0.name == segment.name }) == false {
            pieChartView.segments.append(segment)
        } else {
            for i in 0..<pieChartView.segments.count {
                if pieChartView.segments[i].name == segment.name {
//                    pieChartView.segments[i].value += segment.value
                }
            }
        }
    }
    
    func setSegments(_ segment: [Segment]) {
        print(#function)
        self.pieChartView.segments = segment
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
