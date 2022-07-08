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
        case week = "Week"
        case month = "Month"
        case year = "Year"
        case all = "All"
    }
    
    private(set) var selectedRow: DateType = .day
    private let dataArray = DateType.allCases
    
    private var onCellTappedHandler: ((DateType) -> ())?
}

extension DateCollectionAdapter {
    
    func didSelectState(complition: @escaping(DateType) -> ()) {
        self.onCellTappedHandler = complition
        
        complition(self.selectedRow)
    }
}

extension DateCollectionAdapter: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let count = CGFloat(self.dataArray.count)
        let width = collectionView.frame.width/count
        
        return CGSize(width: width,
                      height: collectionView.frame.height)
    }
}

extension DateCollectionAdapter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        self.selectedRow = self.dataArray[indexPath.item]
        self.onCellTappedHandler?(self.selectedRow)
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
