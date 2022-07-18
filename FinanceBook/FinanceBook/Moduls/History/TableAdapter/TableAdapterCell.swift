//
//  TableAdapterCell.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.07.2022.
//

import UIKit
import SnapKit

final class TableAdapterCell: UITableViewCell {
    
    private enum Constants {
        static let dateLabelFontSize: CGFloat = 14
        static let dateLabelWidth = 120
        
        static let amountLabelLeading = 30
    }
    
    static let id = String(describing: TableAdapterCell.self)
    
    private let amountLabel = UILabel()
    private let colorImageView = UIImageView()
    private let dateLabel = UILabel()
    private let nameLabel = UILabel()
    
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

extension TableAdapterCell {
    
    func update(transaction: HistoryModel) {
        self.amountLabel.text = NumberConverter.toStringFrom(int: transaction.value)
        self.dateLabel.text = DateConverter.toStringFrom(date: transaction.date)
        self.colorImageView.backgroundColor = ColorConverter.toColor(fromData: transaction.color)
        self.nameLabel.text = transaction.name
    }
}

private extension TableAdapterCell {
    
    func configAppearance() {
        self.configAmountLabel()
        self.configDateLabel()
        self.configColorImageView()
    }
    
    func configAmountLabel() {
        self.amountLabel.textColor = MainAttributs.color
    }
    
    func configDateLabel() {
        self.dateLabel.font = .systemFont(ofSize: Constants.dateLabelFontSize)
        self.dateLabel.textColor = .lightGray
    }
    
    func configColorImageView() {
        self.colorImageView.layer.cornerRadius = 20
    }
}

private extension TableAdapterCell {
    
    func makeConstraints() {
        self.makeDateLabelConstraints()
        self.makeAmountLabelConstraints()
        self.makeColorImageViewConstraints()
        self.makeNameLabelConstraints()
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
            make.leading.equalToSuperview().inset(5)
//            make.trailing.equalTo(self.dateLabel.snp.leading)
        }
    }
    
    func makeColorImageViewConstraints() {
        self.addSubview(self.colorImageView)
        self.colorImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.amountLabel.snp.trailing)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }
    
    func makeNameLabelConstraints() {
        self.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.colorImageView.snp.trailing)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
}
