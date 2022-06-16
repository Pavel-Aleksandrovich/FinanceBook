//
//  FavoriteNewsView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit
import SnapKit

protocol IFavoriteNewsView: AnyObject {
    func getTableView() -> UITableView
}

final class FavoriteNewsView: UIView {
    
    private let tableView = UITableView()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.makeTableViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoriteNewsView: IFavoriteNewsView {
    
    func getTableView() -> UITableView {
        self.tableView
    }
}

private extension FavoriteNewsView {
    
    func makeTableViewConstraints() {
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
}
