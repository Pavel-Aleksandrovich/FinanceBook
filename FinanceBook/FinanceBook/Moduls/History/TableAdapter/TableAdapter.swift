//
//  TableAdapter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.07.2022.
//

import UIKit

final class TableAdapter: NSObject {
    
    private enum Constants {
    }
    
    private var dateArray: [HistoryModel] = []
    
    private let onCellDeleteHandler: (UUID) -> ()
    
    init(completion: @escaping(UUID) -> ()) {
        self.onCellDeleteHandler = completion
    }
}

extension TableAdapter {
    
    func setHistory(_ history: [HistoryModel]) {
        self.dateArray = history
    }
}

extension TableAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        self.dateArray.count
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: TableAdapterCell.id,
            for: indexPath) as? TableAdapterCell
        else { return UITableViewCell() }
        
        let type = self.dateArray[indexPath.row]
        cell.update(transaction: type)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let id = self.dateArray[indexPath.row].id
            self.onCellDeleteHandler(id)
        }
    }
}
