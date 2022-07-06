//
//  TransactionDetailsCell.swift
//  FinanceBook
//
//  Created by pavel mishanin on 02.07.2022.
//

import UIKit

final class TransactionDetailsCell: UICollectionViewCell {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 10
    }
    
    static let id = String(describing: TransactionDetailsCell.self)
    
    private let transactionLabel = UILabel()
    private let transactionImageView = UIImageView()
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = self.isSelected ? .systemGray4 : .clear
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
    
    override func layoutSubviews() {
        self.transactionImageView.layer.cornerRadius = self.frame.width/2 - 15
    }
}

extension TransactionDetailsCell {
    
    func config(_ transaction: TransactionType) {
        self.transactionLabel.text = transaction.name
        self.transactionLabel.textColor = transaction.color
        self.transactionImageView.backgroundColor = transaction.color
    }
}

private extension TransactionDetailsCell {
    
    func configAppearance() {
        self.configTransactionLabel()
        self.configView()
        self.configTransactionImageView()
    }
    
    func configView() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = Constants.cornerRadius
    }
    
    func configTransactionLabel() {
        self.transactionLabel.textAlignment = .center
    }
    
    func configTransactionImageView() {
        self.transactionImageView.clipsToBounds = true
    }
}

private extension TransactionDetailsCell {
    
    func makeConstraints() {
        self.makeTransactionImageViewConstraints()
        self.makeTransactionLabelConstraints()
    }
    
    func makeTransactionImageViewConstraints() {
        self.addSubview(self.transactionImageView)
        self.transactionImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(15)
            make.height.equalTo(self.transactionImageView.snp.width)
        }
    }
    
    func makeTransactionLabelConstraints() {
        self.addSubview(self.transactionLabel)
        self.transactionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.transactionImageView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
