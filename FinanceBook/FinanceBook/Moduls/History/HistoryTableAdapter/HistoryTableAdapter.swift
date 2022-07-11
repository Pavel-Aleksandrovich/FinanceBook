//
//  HistoryTableAdapter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

final class HistoryTableAdapter: NSObject {
    
    private enum Constants {
        static let heightForHeaderInSection: CGFloat = 50
        static let heightForFooterInSection: CGFloat = 0
        
        static let heightForRowMax: CGFloat = 40
        static let heightForRowMin: CGFloat = 0
        
        static let fromNumber = 0
    }
    
    private var historyArray: [HistoryViewModel] = []
    
    private let onCellDeleteHandler: (HistoryRequest) -> ()
    
    init(completion: @escaping(HistoryRequest) -> ()) {
        self.onCellDeleteHandler = completion
    }
}

extension HistoryTableAdapter {
    
    func setHistory(_ history: [HistoryViewModel]) {
        self.historyArray = history
    }
}

extension HistoryTableAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.historyArray.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        self.historyArray[section].transaction.count
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        Constants.heightForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.historyArray[indexPath.section].expanded {
        case true:
            return Constants.heightForRowMax
        case false:
            return Constants.heightForRowMin
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForFooterInSection section: Int) -> CGFloat {
        Constants.heightForFooterInSection
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryCell.id,
                                                       for: indexPath) as? HistoryCell
        else { return UITableViewCell() }
        
        let news = self.historyArray[indexPath.section].transaction[indexPath.row]
        cell.update(transaction: news)
        
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
            let chart = self.historyArray[indexPath.section]
            let segment = chart.transaction[indexPath.row]
            let viewModel = HistoryRequest(id: chart.id,
                                           idSegment: segment.id,
                                           transactionCount: chart.transaction.count)
            self.onCellDeleteHandler(viewModel)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let header = HistoryHeaderView()
        let history = self.historyArray[section]
        
        header.setCollapsed(history.expanded)
        
        header.setup(section: section,
                     history: history,
                     delegate: self,
                     tableView: tableView)
        
        return header
    }
}

extension HistoryTableAdapter: HistoryHeaderViewDelegate {
    
    func toggleSection(header: HistoryHeaderView,
                       section: Int,
                       tableView: UITableView) {
        
        let expanded = !self.historyArray[section].expanded
        self.historyArray[section].expanded = expanded
        header.setCollapsed(expanded)
        
        for row in Constants.fromNumber..<self.historyArray[section].transaction.count {
            
            tableView.reloadRows(at: [IndexPath(row: row, section: section)],
                                  with: .automatic)
        }
    }
}
