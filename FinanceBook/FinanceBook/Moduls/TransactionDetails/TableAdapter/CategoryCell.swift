//
//  TransactionDetailsCell.swift
//  FinanceBook
//
//  Created by pavel mishanin on 07.07.2022.
//

import UIKit
import SnapKit

final class CategoryCell: UITableViewCell {
    
    private enum Constants {
        static let dateLabelFontSize: CGFloat = 14
        static let dateLabelWidth = 120
        
        static let amountLabelLeading = 30
    }
    
    static let id = String(describing: CategoryCell.self)
    
    private let titleLabel = UILabel()
    private let nameLabel = UILabel()
    private let vStackView = UIStackView()
    
    private var isEmptyLabel: Bool = true {
        didSet {
            switch self.isEmptyLabel {
            case true:
                self.titleLabel.font = UIFont.systemFont(ofSize: 25)
            case false:
                self.titleLabel.font = UIFont.systemFont(ofSize: 17)
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.makeConstraints()
        self.configAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryCell {
    
    func update(name: String?) {
        if name != nil {
            self.nameLabel.text = name
            self.isEmptyLabel = false
        } else {
            self.isEmptyLabel = true
        }
    }
}

// MARK: - Config Appearance
private extension CategoryCell {
    
    func configAppearance() {
        self.configStackView()
        self.configTitleLabel()
        self.configNameLabel()
    }
    
    func configStackView() {
        self.vStackView.axis = .vertical
        self.vStackView.alignment = .leading
        self.vStackView.distribution = .fillProportionally
    }
    
    func configTitleLabel() {
        self.titleLabel.text = "Category"
        self.titleLabel.font = UIFont.systemFont(ofSize: 25)
    }
    
    func configNameLabel() {
        self.nameLabel.font = UIFont.systemFont(ofSize: 25)
    }
}

// MARK: - Make Constraints
private extension CategoryCell {
    
    func makeConstraints() {
        self.makeStackViewConstraints()
    }
    
    func makeStackViewConstraints() {
        self.addSubview(self.vStackView)
        self.vStackView.addArrangedSubview(self.titleLabel)
        self.vStackView.addArrangedSubview(self.nameLabel)
        
        self.vStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(7)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}
