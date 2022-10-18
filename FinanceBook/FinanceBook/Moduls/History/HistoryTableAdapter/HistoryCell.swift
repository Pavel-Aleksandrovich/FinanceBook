//
//  HistoryCell.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit
import SnapKit

final class HistoryCell: UITableViewCell {
    
    private enum Constants {
        static let dateLabelFontSize: CGFloat = 14
        static let dateLabelWidth = 120
        
        static let amountLabelLeading = 30
    }
    
    static let id = String(describing: HistoryCell.self)
    
    private let amountLabel = BaseLabel()
    private let dateLabel = BaseLabel()
    
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

extension HistoryCell {
    
    func update(transaction: HistoryModel) {
        self.amountLabel.text = NumberConverter.toStringFrom(int: transaction.value)
        self.dateLabel.text = DateConverter.toStringFrom(date: transaction.date)
    }
}

private extension HistoryCell {
    
    func configAppearance() {
        self.configAmountLabel()
        self.configDateLabel()
    }
    
    func configAmountLabel() {
        self.amountLabel.textColor = MainAttributs.color
    }
    
    func configDateLabel() {
        self.dateLabel.font = .systemFont(ofSize: Constants.dateLabelFontSize)
        self.dateLabel.textColor = .lightGray
    }
    
    func makeConstraints() {
        self.makeDateLabelConstraints()
        self.makeAmountLabelConstraints()
    }
    
    func makeDateLabelConstraints() {
        self.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(Constants.dateLabelWidth)
        }
    }
    
    func makeAmountLabelConstraints() {
        self.addSubview(self.amountLabel)
        self.amountLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(Constants.amountLabelLeading)
            make.trailing.equalTo(self.dateLabel.snp.leading)
        }
    }
}
