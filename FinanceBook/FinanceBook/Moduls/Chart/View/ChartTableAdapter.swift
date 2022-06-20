//
//  ChartTableAdapter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

protocol ChartTableAdapterDelegate: AnyObject {
    func loadImageData(url: String?, complition: @escaping(Data) -> ())
}

protocol IChartTableAdapter: AnyObject {
    var delegate: ChartTableAdapterDelegate? { get set }
    var tableView: UITableView? { get set }
    var onCellDeleteHandler: ((DeleteViewModelRequest) -> ())? { get set }
    
    func setCharts(_ chart: [ChartViewModelResponse])
}

final class ChartTableAdapter: NSObject {
    
    private var articleArray: [ChartViewModelResponse] = []
    var onCellDeleteHandler: ((DeleteViewModelRequest) -> ())?
    weak var delegate: ChartTableAdapterDelegate?
    weak var tableView: UITableView? {
        didSet {
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
            self.tableView?.register(ChartCell.self,
                                     forCellReuseIdentifier: ChartCell.id)
        }
    }
}

extension ChartTableAdapter: IChartTableAdapter {

    func setCharts(_ chart: [ChartViewModelResponse]) {
        self.articleArray = chart
        self.tableView?.reloadData()
    }
}

extension ChartTableAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.articleArray.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        articleArray[section].segment.count
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        articleArray[indexPath.section].expanded ? 40 : 0
    }
    
    func tableView(_ tableView: UITableView,
                            heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChartCell.id,
                                                       for: indexPath) as? ChartCell else { return UITableViewCell() }
        
        let news = articleArray[indexPath.section].segment[indexPath.row]
        cell.update(article: news)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let chart = articleArray[indexPath.section]
            let segment = chart.segment[indexPath.row]
            let viewModel = DeleteViewModelRequest(id: chart.id,
                                                   idSegment: segment.id,
                                                   segmentsCount: chart.segment.count)
            self.onCellDeleteHandler?(viewModel)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let header = ChartHeaderView()
        let chart = articleArray[section]
        
        header.setCollapsed(articleArray[section].expanded)
        
        header.setup(section: section,
                     chart: chart,
                     delegate: self)
        return header
    }
}

extension ChartTableAdapter: ChartHeaderViewDelegate {
    
    func toggleSection(header: ChartHeaderView, section: Int) {
        
        let expanded = !articleArray[section].expanded
        articleArray[section].expanded = expanded
        header.setCollapsed(expanded)
        
        for row in 0..<articleArray[section].segment.count {
            tableView?.reloadRows(at: [IndexPath(row: row, section: section)],
                                  with: .automatic)
        }
    }
}
