//
//  DateCollectionAdapter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 08.07.2022.
//

import UIKit

final class DateCollectionAdapter: NSObject {
    
    private enum Constants {
    }
    
    enum DateType: String, CaseIterable {
        case day = "Day"
        case month = "Month"
        case year = "Year"
        case all = "All"
    }
    
    private let dataArray = DateType.allCases
    private let onCellTappedHandler: (DateType) -> ()
    
    init(completion: @escaping(DateType) -> ()) {
        self.onCellTappedHandler = completion
    }
}

extension DateCollectionAdapter: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let count = CGFloat(self.dataArray.count)
        
        return CGSize(width: collectionView.frame.width/count,
                      height: collectionView.frame.height)
    }
}

extension DateCollectionAdapter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let selectedRow = self.dataArray[indexPath.item]
        self.onCellTappedHandler(selectedRow)
    }
}

extension DateCollectionAdapter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        self.dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: DateCollectionCell.id,
            for: indexPath) as? DateCollectionCell
        else { return UICollectionViewCell() }
        
        let transaction = self.dataArray[indexPath.item]
        cell.config(transaction.rawValue)
        
        return cell
    }
}
