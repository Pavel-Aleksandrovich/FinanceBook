//
//  ProfitCollectionView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 06.07.2022.
//

import UIKit

enum Profit: String, CaseIterable {
    case income = "Income"
    case expenses = "Expenses"
}

final class ProfitCollectionAdapter: NSObject {
    
    private enum Constants {
    }
    
    private(set) var selectedRow: Profit = .income
    private let transactionTypeArray = Profit.allCases
    
    private var onCellTappedHandler: ((Profit) -> ())?
}

extension ProfitCollectionAdapter {
    
    func didSelectState(complition: @escaping(Profit) -> ()) {
        self.onCellTappedHandler = complition
        
        complition(.income)
    }
}

extension ProfitCollectionAdapter: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/2
        
        return CGSize(width: width,
                      height: 50)
    }
}

extension ProfitCollectionAdapter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        self.selectedRow = self.transactionTypeArray[indexPath.item]
        self.onCellTappedHandler?(self.selectedRow)
    }
}

extension ProfitCollectionAdapter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        self.transactionTypeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ProfitCollectionCell.id,
            for: indexPath) as? ProfitCollectionCell else { return UICollectionViewCell() }
        
        let transaction = self.transactionTypeArray[indexPath.item]
        cell.config(transaction.rawValue)
        
        return cell
    }
}
