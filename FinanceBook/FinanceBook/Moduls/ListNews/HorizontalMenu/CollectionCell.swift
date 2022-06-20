//
//  CollectionCell.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit

final class CollectionCell: UICollectionViewCell {
    
    static let id = String(describing: CollectionCell.self)
    
    private let categoryLabel = UILabel()
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = self.isSelected ? .lightGray : .systemGray4
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configAppearance()
        self.configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionCell {
    
    func config(_ category: String) {
        self.categoryLabel.text = category
    }
}

private extension CollectionCell {
    
    // MARK: - Appearance
    
    func configAppearance() {
        self.configImageNameLabel()
        self.configView()
    }
    
    func configView() {
        self.backgroundColor = .systemGray4
        self.layer.cornerRadius = 5
    }
    
    func configImageNameLabel() {
        self.categoryLabel.textAlignment = .center
    }
    
    // MARK: - Constraints | Layout
    
    func configLayout() {
        self.makeImageNameLabelConstraints()
    }
    
    func makeImageNameLabelConstraints() {
        self.addSubview(self.categoryLabel)
        self.categoryLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
