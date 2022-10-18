//
//  ProfitCollectionCell.swift
//  FinanceBook
//
//  Created by pavel mishanin on 06.07.2022.
//

import UIKit

final class ProfitCollectionCell: UICollectionViewCell {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 5
    }
    
    static let id = String(describing: ProfitCollectionCell.self)
    
    private let categoryLabel = UILabel()
    private let selectView = UIView()
    
    override var isSelected: Bool {
        didSet {
            self.configSelectView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configAppearance()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfitCollectionCell {
    
    func config(_ text: String) {
        self.categoryLabel.text = text
    }
}

// MARK: - Config Appearance
private extension ProfitCollectionCell {
    
    func configAppearance() {
        self.configImageNameLabel()
        self.configView()
        self.configSelectView()
    }
    
    func configView() {
        self.backgroundColor = .white
    }
    
    func configImageNameLabel() {
        self.categoryLabel.textAlignment = .center
    }
    
    func configSelectView() {
        if self.isSelected {
            self.selectView.backgroundColor = MainAttributs.color
        } else {
            self.selectView.backgroundColor = .systemGray6
        }
    }
}

// MARK: - Make Constraints
private extension ProfitCollectionCell {
    
    func makeConstraints() {
        self.makeImageNameLabelConstraints()
        self.makeSelectViewConstraints()
    }
    
    func makeImageNameLabelConstraints() {
        self.addSubview(self.categoryLabel)
        self.categoryLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    func makeSelectViewConstraints() {
        self.addSubview(self.selectView)
        self.selectView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(4)
        }
    }
}
