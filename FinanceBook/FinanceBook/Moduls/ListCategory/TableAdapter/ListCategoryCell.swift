//
//  ListCategoryCell.swift
//  FinanceBook
//
//  Created by pavel mishanin on 06.07.2022.
//

import UIKit
import SnapKit

final class ListCategoryCell: UITableViewCell {
    
    private enum Constants {
        static let dateLabelFontSize: CGFloat = 14
        static let dateLabelWidth = 120
        
        static let amountLabelLeading = 30
    }
    
    static let id = String(describing: ListCategoryCell.self)
    
    private let colorImageView = UIImageView()
    private let nameLabel = UILabel()
    
    override var isSelected: Bool {
        didSet {
            self.nameLabel.textColor = !self.isSelected ? .red : .clear
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

extension ListCategoryCell {
    
    func update(name: String?, color: UIColor?) {
        self.nameLabel.text = name
        self.colorImageView.backgroundColor = color
    }
}

// MARK: - Config Appearance
private extension ListCategoryCell {
    
    func configAppearance() {
        self.configColorImageView()
    }
    
    func configColorImageView() {
        self.colorImageView.layer.cornerRadius = 20
    }
}

// MARK: - Make Constraints
private extension ListCategoryCell {
    
    func makeConstraints() {
        self.makeColorImageViewConstraints()
        self.makeNameLabelConstraints()
    }
    
    func makeColorImageViewConstraints() {
        self.addSubview(self.colorImageView)
        self.colorImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }
    
    func makeNameLabelConstraints() {
        self.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.colorImageView.snp.trailing).inset(-10)
            make.top.bottom.trailing.equalToSuperview()
        }
    }
}
