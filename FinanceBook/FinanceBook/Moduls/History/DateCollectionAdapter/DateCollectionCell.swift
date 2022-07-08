//
//  DateCollectionCell.swift
//  FinanceBook
//
//  Created by pavel mishanin on 08.07.2022.
//

import UIKit

final class DateCollectionCell: UICollectionViewCell {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 5
    }
    
    static let id = String(describing: DateCollectionCell.self)
    
    private let categoryLabel = UILabel()
    private let selectView = UIView()
    
    override var isSelected: Bool {
        didSet {
            self.selectView.isHidden = !self.isSelected
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

extension DateCollectionCell {
    
    func config(_ text: String) {
        self.categoryLabel.text = text
    }
}

private extension DateCollectionCell {
    
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
        self.selectView.backgroundColor = MainAttributs.color
        self.selectView.isHidden = true
    }
}

private extension DateCollectionCell {
    
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
            make.height.equalTo(2)
        }
    }
}
