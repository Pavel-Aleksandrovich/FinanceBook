//
//  ListNewsView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit
import SnapKit

protocol IListNewsView: AnyObject {
    func getTableView() -> UITableView
    func getCollectionView() -> UICollectionView
}

final class ListNewsView: UIView {
    
    private let layout = UICollectionViewFlowLayout()
    private let tableView = UITableView()
    private var collectionView: UICollectionView!
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.layout.minimumInteritemSpacing = 5
        self.layout.scrollDirection = .horizontal
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.backgroundColor = .clear
        self.collectionView.showsHorizontalScrollIndicator = false
        self.makeCollectionViewConstraints()
        self.makeTableViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListNewsView: IListNewsView {
    
    func getTableView() -> UITableView {
        self.tableView
    }
    
    func getCollectionView() -> UICollectionView {
        self.collectionView
    }
}

private extension ListNewsView {
    
    func makeTableViewConstraints() {
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.collectionView.snp.bottom).inset(-5)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func makeCollectionViewConstraints() {
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalToSuperview().inset(5)
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}
