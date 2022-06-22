//
//  File.swift
//  FinanceBook
//
//  Created by pavel mishanin on 21.06.2022.
//

import UIKit
import SnapKit

final class ListNewsLoadingCell: UITableViewCell {
    
    static let id = String(describing: ListNewsLoadingCell.self)
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let loadingLabel = BaseLabel()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        self.addSubview(self.errorLabel)
//        self.errorLabel.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension ListNewsLoadingCell {
}
