//
//  CollectionCell.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit

final class CollectionCell: UICollectionViewCell {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 5
    }
    
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
        self.makeConstraints()
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
    
    func configAppearance() {
        self.configImageNameLabel()
        self.configView()
    }
    
    func configView() {
        self.backgroundColor = .systemGray4
        self.layer.cornerRadius = Constants.cornerRadius
    }
    
    func configImageNameLabel() {
        self.categoryLabel.textAlignment = .center
    }
    
    func makeConstraints() {
        self.makeImageNameLabelConstraints()
    }
    
    func makeImageNameLabelConstraints() {
        self.addSubview(self.categoryLabel)
        self.categoryLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
