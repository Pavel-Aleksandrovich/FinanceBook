//
//  ChartTableAdapter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

protocol IHistoryTableAdapter: AnyObject {
    var tableView: UITableView? { get set }
    var onCellDeleteHandler: ((HistoryRequest) -> ())? { get set }
    func setCharts(_ chart: [HistoryViewModel])
}

final class HistoryTableAdapter: NSObject {
    
    private var articleArray: [HistoryViewModel] = []
    
    var onCellDeleteHandler: ((HistoryRequest) -> ())?
    
    weak var tableView: UITableView? {
        didSet {
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
        }
    }
}

extension HistoryTableAdapter: IHistoryTableAdapter {

    func setCharts(_ chart: [HistoryViewModel]) {
        self.articleArray = chart
        self.tableView?.reloadData()
    }
}

extension HistoryTableAdapter: UITableViewDelegate, UITableViewDataSource {
    
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.id,
                                                       for: indexPath) as? HistoryCell else { return UITableViewCell() }
        
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
            let viewModel = HistoryRequest(id: chart.id,
                                                   idSegment: segment.id,
                                                   transactionTypeCount: chart.segment.count)
            self.onCellDeleteHandler?(viewModel)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let header = HistoryHeaderView()
        let chart = articleArray[section]
        
        header.setCollapsed(articleArray[section].expanded)
        
        header.setup(section: section,
                     chart: chart,
                     delegate: self)
        return header
    }
}

extension HistoryTableAdapter: HistoryHeaderViewDelegate {
    
    func toggleSection(header: HistoryHeaderView, section: Int) {
        
        let expanded = !articleArray[section].expanded
        articleArray[section].expanded = expanded
        header.setCollapsed(expanded)
        
        for row in 0..<articleArray[section].segment.count {
            tableView?.reloadRows(at: [IndexPath(row: row, section: section)],
                                  with: .automatic)
        }
    }
}
