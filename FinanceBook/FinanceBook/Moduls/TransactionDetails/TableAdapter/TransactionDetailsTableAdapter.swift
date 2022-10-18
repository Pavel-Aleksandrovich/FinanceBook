//
//  TransactionDetailsTableAdapter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 07.07.2022.
//

import UIKit

final class TransactionDetailsTableAdapter: NSObject {
    
    private enum Constants {}
    
    enum CellType: Int, CaseIterable {
        case category
        case date
        case amount
    }
    
    private(set) var selectedDate: String? = nil
    private(set) var selectedAmount: String? = nil
    
    var selectedCategory: CategoryType? = nil {
        didSet {
            self.textFieldChangeHandler?()
        }
    }
    
    private var array = CellType.allCases
    
    private var typeDidSetHandler: ((CategoryType) -> ())?
    
    var onCellTappedHandler: ((CellType) -> ())?
    var textFieldChangeHandler: (() -> ())?
}

extension TransactionDetailsTableAdapter {}

extension TransactionDetailsTableAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        self.array.count
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let type = self.array[indexPath.row]
        
        switch type {
        case .category:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CategoryCell.id,
                for: indexPath) as? CategoryCell
            else { return UITableViewCell() }
            
            let name = self.selectedCategory?.name
            cell.update(name: name)
            cell.accessoryType = .disclosureIndicator
            
            return cell
        case .date:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DateCell.id,
                for: indexPath) as? DateCell
            else { return UITableViewCell() }
            
            cell.textFieldHandler = { date in
                self.selectedDate = date
                self.textFieldChangeHandler?()
            }
            
            cell.contentView.isUserInteractionEnabled = false
            cell.selectionStyle = .none
            
            return cell
            
        case .amount:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: AmountCell.id,
                for: indexPath) as? AmountCell
            else { return UITableViewCell() }
            
            cell.textFieldHandler = { amount in
                self.selectedAmount = amount
                self.textFieldChangeHandler?()
            }
            
            cell.contentView.isUserInteractionEnabled = false
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let type = self.array[indexPath.row]
        
        switch type {
        case .category:
            self.onCellTappedHandler?(.category)
        case .date:
            print("date")
        case .amount: break
        }
    }
}
