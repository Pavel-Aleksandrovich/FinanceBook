//
//  CategoryTableAdapter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 06.07.2022.
//

import UIKit

final class CategoryTableAdapter: NSObject {
    
    private enum Constants {
    }
    
    private var selectedRow: ProfitType = .income(.home)
    
    private(set) var model: CategoryType? = nil {
        didSet {
            self.onCellTappedHandler?(self.model)
        }
    }
    
    private var onCellTappedHandler: ((CategoryType?) -> ())?
}

extension CategoryTableAdapter {
    
    func didSelectType(_ result: Profit) {
        self.model = nil
        
        switch result {
        case .income:
            self.selectedRow = .income(.home)
        case .expenses:
            self.selectedRow = .expenses(.salary)
        }
    }
    
    func setStateListener(complition: @escaping(CategoryType?) -> ()) {
        self.onCellTappedHandler = complition
        
        complition(self.model)
    }
}

extension CategoryTableAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        switch self.selectedRow {
        case .income(_):
            return TransactionType.allCases.count
        case .expenses(_):
            return ExpensesType.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.id,
                                                       for: indexPath) as? CategoryCell
        else { return UITableViewCell() }
        
        switch self.selectedRow {
        case .income(_):
            let transaction = TransactionType.allCases[indexPath.item]
            cell.update(name: transaction.name, color: transaction.color)
        case .expenses(_):
            let transaction = ExpensesType.allCases[indexPath.item]
            cell.update(name: transaction.name, color: transaction.color)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var name = String()
        var color = UIColor()
        
        switch self.selectedRow {
        case .income(_):
            color = TransactionType.allCases[indexPath.row].color
            name = TransactionType.allCases[indexPath.row].name
        case .expenses(_):
            color = ExpensesType.allCases[indexPath.row].color
            name = ExpensesType.allCases[indexPath.row].name
        }
        
        self.model = CategoryType(name: name, color: color)
    }
}
