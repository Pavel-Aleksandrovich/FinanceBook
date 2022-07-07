//
//  TransactionDetailsCollectionViewAdapter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 02.07.2022.
//

//import UIKit
//
//final class TransactionDetailsCollectionView: NSObject {
//    
//    private enum Constants {
//    }
//    
//    private(set) var selectedColor: UIColor? = nil
//    private(set) var selectedName: String? = nil
//    private(set) var selectedRow: ProfitType = .income(.home)
//    private var transactionTypeArray = ProfitType.allCases
//}
//
//extension TransactionDetailsCollectionView {
//    
//    func didSelectType(_ result: Profit) {
//        switch result {
//        case .income:
//            self.selectedRow = .income(.home)
//        case .expenses:
//            self.selectedRow = .expenses(.salary)
//        }
//    }
//}
//
//extension TransactionDetailsCollectionView: UICollectionViewDelegateFlowLayout {
//    
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.frame.width/4
//        let height = width * 1.3
//        
//        return CGSize(width: width,
//                      height: height)
//    }
//}
//
//extension TransactionDetailsCollectionView: UICollectionViewDelegate {
//    
//    func collectionView(_ collectionView: UICollectionView,
//                        didSelectItemAt indexPath: IndexPath) {
//        switch self.selectedRow {
//        case .income(_):
//            self.selectedColor = TransactionType.allCases[indexPath.row].color
//            self.selectedName = TransactionType.allCases[indexPath.row].name
//        case .expenses(_):
//            self.selectedColor = ExpensesType.allCases[indexPath.row].color
//            self.selectedName = ExpensesType.allCases[indexPath.row].name
//        }
//    }
//}
//
//extension TransactionDetailsCollectionView: UICollectionViewDataSource {
//    
//    func collectionView(_ collectionView: UICollectionView,
//                        numberOfItemsInSection section: Int) -> Int {
//        switch self.selectedRow {
//        case .income(_):
//            return TransactionType.allCases.count
//        case .expenses(_):
//            return ExpensesType.allCases.count
//        }
//    }
//    
//    func collectionView(_ collectionView: UICollectionView,
//                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        guard let cell = collectionView.dequeueReusableCell(
//            withReuseIdentifier: TransactionDetailsCell.id,
//            for: indexPath) as? TransactionDetailsCell else { return UICollectionViewCell() }
//        
//        switch self.selectedRow {
//        case .income(_):
//            let transaction = TransactionType.allCases[indexPath.item]
//            cell.config(name: transaction.name, color: transaction.color)
//        case .expenses(_):
//            let transaction = ExpensesType.allCases[indexPath.item]
//            cell.config(name: transaction.name, color: transaction.color)
//        }
//        
//        return cell
//    }
//}
