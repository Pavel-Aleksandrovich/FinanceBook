//
//  TransactionDetailsCollectionViewAdapter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 02.07.2022.
//

import UIKit
import SnapKit

protocol ITransactionDetailsCollectionView {
    var collectionView: UICollectionView? { get set }
    var onCellTappedHandler: ((String) -> ())? { get set }
}

final class TransactionDetailsCollectionView: NSObject {
    
    private enum Constants {
        static let fontSize: CGFloat = 18
        static let defaultWidth: CGFloat = 20
        static let selectedItemAtIndexPath: IndexPath = [0, 0]
    }
    
    private let transactionTypeArray = TransactionType.allCases
    
    var onCellTappedHandler: ((String) -> ())?
    
    weak var collectionView: UICollectionView? {
        didSet {
            self.collectionView?.delegate = self
            self.collectionView?.dataSource = self
            self.collectionView?.selectItem(at: Constants.selectedItemAtIndexPath,
                                            animated: true,
                                            scrollPosition: [])
        }
    }
}

extension TransactionDetailsCollectionView: ITransactionDetailsCollectionView {}

extension TransactionDetailsCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let font = UIFont.systemFont(ofSize: Constants.fontSize)
        let attributes = [NSAttributedString.Key.font : font as Any]
        let width = Category.allCases[indexPath.item]
            .rawValue.size(withAttributes: attributes).width + Constants.defaultWidth
        
        return CGSize(width: width,
                      height: collectionView.frame.height)
    }
}

extension TransactionDetailsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: true)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        transactionTypeArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TransactionDetailsCell.id,
            for: indexPath) as? TransactionDetailsCell else { return UICollectionViewCell() }
        
        let category = transactionTypeArray[indexPath.item].rawValue
        cell.config(category)
        
        return cell
    }
}
