//
//  CategoryTableAdapter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 06.07.2022.
//

import UIKit

final class ListCategoryTableAdapter: NSObject {
    
    private enum Constants {
    }
    
    private var selectedRow: ProfitType = .income
    
    private(set) var model: CategoryType? = nil {
        didSet {
            self.onCellTappedHandler?(self.model)
        }
    }
    
    private var onCellTappedHandler: ((CategoryType?) -> ())?
}

extension ListCategoryTableAdapter {
    
    func didSelectType(_ result: Profit) {
        self.model = nil
        
        switch result {
        case .income:
            self.selectedRow = .income
        case .expenses:
            self.selectedRow = .expenses
        }
    }
    
    func setStateListener(complition: @escaping(CategoryType?) -> ()) {
        self.onCellTappedHandler = complition
        
        complition(self.model)
    }
}

extension ListCategoryTableAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch self.selectedRow {
        case .income:
            return TransactionType.allCases.count
        case .expenses:
            return ExpensesType.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListCategoryCell.id,
            for: indexPath) as? ListCategoryCell
        else { return UITableViewCell() }
        
        switch self.selectedRow {
        case .income:
            let transaction = TransactionType.allCases[indexPath.item]
            cell.update(name: transaction.name, color: transaction.color)
        case .expenses:
            let transaction = ExpensesType.allCases[indexPath.item]
            cell.update(name: transaction.name, color: transaction.color)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        var name = String()
        var color = UIColor()
        let profit = self.selectedRow.rawValue
        
        switch self.selectedRow {
        case .income:
            color = TransactionType.allCases[indexPath.row].color
            name = TransactionType.allCases[indexPath.row].name
        case .expenses:
            color = ExpensesType.allCases[indexPath.row].color
            name = ExpensesType.allCases[indexPath.row].name
        }
        
        self.model = CategoryType(name: name,
                                  color: color,
                                  profit: profit)
    }
}
