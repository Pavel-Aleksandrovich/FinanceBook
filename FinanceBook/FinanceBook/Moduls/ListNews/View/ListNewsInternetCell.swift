//
//  ListNewsInternetCell.swift
//  FinanceBook
//
//  Created by pavel mishanin on 28.06.2022.
//

import UIKit
import SnapKit

final class ListNewsInternetCell: UITableViewCell {
    
    private enum Constants {
        static let messageLabelText = "No Internet connection. Try again later"
        static let messageLabelLeading = 10
        static let messageLabelNumberOfLines = 0
    }
    
    static let id = String(describing: ListNewsInternetCell.self)
    
    private let messageLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configAppearance()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Config Appearance
private extension ListNewsInternetCell {
    
    func configAppearance() {
        self.configMessageLabel()
    }
    
    func configMessageLabel() {
        self.messageLabel.textAlignment = .center
        self.messageLabel.numberOfLines = Constants.messageLabelNumberOfLines
        self.messageLabel.text = Constants.messageLabelText
    }
}

// MARK: - Make Constraints
private extension ListNewsInternetCell {
    
    func makeConstraints() {
        self.makeMessageLabelConstraints()
    }

    func makeMessageLabelConstraints() {
        self.addSubview(self.messageLabel)
        self.messageLabel.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
                .inset(Constants.messageLabelLeading)
        }
    }
}
