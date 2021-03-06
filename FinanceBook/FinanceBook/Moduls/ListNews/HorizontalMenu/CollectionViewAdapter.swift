//
//  CollectionViewAdapter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit
import SnapKit

protocol ICollectionViewAdapter {
    var collectionView: UICollectionView? { get set }
    var onCellTappedHandler: ((String) -> ())? { get set }
}

final class CollectionViewAdapter: NSObject {
    
    private enum Constants {
        static let fontSize: CGFloat = 18
        static let defaultWidth: CGFloat = 20
        static let selectedItemAtIndexPath: IndexPath = [0, 0]
    }
    
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

extension CollectionViewAdapter: ICollectionViewAdapter {}

extension CollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    
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

extension CollectionViewAdapter: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: true)
        self.onCellTappedHandler?(Category.allCases[indexPath.item].rawValue)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        Category.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionCell.id,
            for: indexPath) as? CollectionCell else { return UICollectionViewCell() }
        
        let category = Category.allCases[indexPath.item].rawValue
        cell.config(category)
        
        return cell
    }
}
