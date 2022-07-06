//
//  TransactionDetailsCollectionViewAdapter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 02.07.2022.
//

import UIKit
import SnapKit

final class TransactionDetailsCollectionView: NSObject {
    
    private enum Constants {
    }
    
    private(set) var selectedRow: TransactionType = .home
    private let transactionTypeArray = TransactionType.allCases
}

extension TransactionDetailsCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/4
        let height = width * 1.3
        
        return CGSize(width: width,
                      height: height)
    }
}

extension TransactionDetailsCollectionView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        self.selectedRow = self.transactionTypeArray[indexPath.item]
    }
}

extension TransactionDetailsCollectionView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        self.transactionTypeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TransactionDetailsCell.id,
            for: indexPath) as? TransactionDetailsCell else { return UICollectionViewCell() }
        
        let transaction = self.transactionTypeArray[indexPath.item]
        cell.config(transaction)
        
        return cell
    }
}
