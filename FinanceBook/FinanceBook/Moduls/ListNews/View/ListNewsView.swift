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
}

final class ListNewsView: UIView {
    
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

extension ListNewsView: IListNewsView {
    
    func getTableView() -> UITableView {
        self.tableView
    }
}

private extension ListNewsView {
    
    func makeTableViewConstraints() {
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
}
