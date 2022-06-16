//
//  CollectionCell.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit

final class CollectionCell: UICollectionViewCell {
    
    private let categoryLabel = UILabel()
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = self.isSelected ? .lightGray : .systemGray4
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configAppearance()
        configLayout()
        backgroundColor = .systemGray4
        layer.cornerRadius = 5
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionCell {
    
    func config(_ category: String) {
        categoryLabel.text = category
    }
}

private extension CollectionCell {
    
    // MARK: - Appearance
    
    func configAppearance() {
        configImageNameLabel()
    }
    
    func configImageNameLabel() {
        categoryLabel.textAlignment = .center
    }
    
    // MARK: - Constraints | Layout
    
    func configLayout() {
        makeImageNameLabelConstraints()
    }
    
    func makeImageNameLabelConstraints() {
        addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
