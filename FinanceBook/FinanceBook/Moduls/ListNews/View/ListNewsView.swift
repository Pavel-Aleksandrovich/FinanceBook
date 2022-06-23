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
    
    private enum Constants {
        static let layoutSpacing: CGFloat = 5
        
        static let tableViewTop = -5
        
        static let collectionViewLeading = 5
        static let collectionViewHeight = 50
    }
    
    private let layout = UICollectionViewFlowLayout()
    private let tableView = UITableView()
    
    private var collectionView: UICollectionView!
    
    init() {
        super.init(frame: .zero)
        self.configAppearance()
        self.makeConstraints()
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

// MARK: - Config Appearance
private extension ListNewsView {
    
    func configAppearance() {
        self.configView()
        self.configLayout()
        self.configCollectionView()
        self.configTableView()
    }
    
    func configView() {
        self.backgroundColor = .white
    }
    
    func configLayout() {
        self.layout.minimumInteritemSpacing = Constants.layoutSpacing
        self.layout.scrollDirection = .horizontal
    }
    
    func configCollectionView() {
        self.collectionView = UICollectionView(frame: .zero,
                                               collectionViewLayout: layout)
        self.collectionView.backgroundColor = .clear
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(CollectionCell.self,
                                      forCellWithReuseIdentifier: CollectionCell.id)
    }
    
    func configTableView() {
        self.tableView.register(ListNewsCell.self,
                                 forCellReuseIdentifier: ListNewsCell.id)
        self.tableView.register(ListNewsLoadingCell.self,
                                 forCellReuseIdentifier: ListNewsLoadingCell.id)
    }
}

// MARK: - Make Constraints
private extension ListNewsView {
    
    func makeConstraints() {
        self.makeCollectionViewConstraints()
        self.makeTableViewConstraints()
    }
    
    func makeTableViewConstraints() {
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.equalTo(self.collectionView.snp.bottom)
                .inset(Constants.tableViewTop)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func makeCollectionViewConstraints() {
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.equalToSuperview()
                .inset(Constants.collectionViewLeading)
            make.trailing.equalToSuperview()
            make.height.equalTo(Constants.collectionViewHeight)
        }
    }
}
