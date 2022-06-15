//
//  ListCompaniesView.swift
//  Homework-10
//
//  Created by pavel mishanin on 08.06.2022.
//

import UIKit
import SnapKit

protocol IListCompaniesView: AnyObject {
    func getTableView() -> UITableView
}

final class ListCompaniesView: UIView {
    
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

extension ListCompaniesView: IListCompaniesView {
    
    func getTableView() -> UITableView {
        self.tableView
    }
}

private extension ListCompaniesView {
    
    func makeTableViewConstraints() {
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
    }
}
