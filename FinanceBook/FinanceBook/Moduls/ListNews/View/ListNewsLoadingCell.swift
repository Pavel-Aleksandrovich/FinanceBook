//
//  ListNewsLoadingCell.swift
//  FinanceBook
//
//  Created by pavel mishanin on 21.06.2022.
//

import UIKit
import SnapKit

final class ListNewsLoadingCell: UITableViewCell {
    
    private enum Constants {
        static let loadingLabelText = "Loading ..."
        static let loadingLabelTop = -10
        static let loadingLabelLeading = 10
    }
    
    static let id = String(describing: ListNewsLoadingCell.self)
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let loadingLabel = BaseLabel()
    
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
private extension ListNewsLoadingCell {
    
    func configAppearance() {
        self.configActivityIndicator()
        self.configLoadingLabel()
    }
    
    func configActivityIndicator() {
        self.activityIndicator.startAnimating()
    }
    
    func configLoadingLabel() {
        self.loadingLabel.textAlignment = .center
        self.loadingLabel.text = Constants.loadingLabelText
    }
}

// MARK: - Make Constraints
private extension ListNewsLoadingCell {
    
    func makeConstraints() {
        self.makeActivityIndicatorConstraints()
        self.makeLoadingLabelConstraints()
    }
    
    func makeActivityIndicatorConstraints() {
        self.addSubview(self.activityIndicator)
        self.activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func makeLoadingLabelConstraints() {
        self.addSubview(self.loadingLabel)
        self.loadingLabel.snp.makeConstraints { make in
            make.top.equalTo(self.activityIndicator.snp.bottom)
                .inset(Constants.loadingLabelTop)
            make.leading.trailing.equalToSuperview()
                .inset(Constants.loadingLabelLeading)
        }
    }
}
