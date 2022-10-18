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
    
    private var historyArray: [[HistoryModel]] = []
    
    private let onCellDeleteHandler: (UUID) -> ()
    
    init(completion: @escaping(UUID) -> ()) {
        self.onCellDeleteHandler = completion
    }
}

extension HistoryTableAdapter {
    
    func setHistory(_ history: [[HistoryModel]]) {
        self.historyArray = history
    }
}

extension HistoryTableAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        self.historyArray.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        self.historyArray[section].count
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        Constants.heightForHeaderInSection
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let isExpanded = self.historyArray[indexPath.section].first?.expanded else { return Constants.heightForRowMin }
        
        switch isExpanded {
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
        
        let history = self.historyArray[indexPath.section]
        
        cell.update(transaction: history[indexPath.row])
        
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
            let history = self.historyArray[indexPath.section]
            self.onCellDeleteHandler(history[indexPath.row].id)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        let header = HistoryHeaderView()
        let history = self.historyArray[section]
        
        guard let expanded = history.first?.expanded else { return nil }
        
        header.setCollapsed(expanded)
        
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
        
        let expanded = !self.historyArray[section].first!.expanded
        self.historyArray[section][0].expanded = expanded
        header.setCollapsed(expanded)
        
        for row in Constants.fromNumber..<self.historyArray[section].count {
            
            tableView.reloadRows(at: [IndexPath(row: row, section: section)],
                                  with: .automatic)
        }
    }
}
