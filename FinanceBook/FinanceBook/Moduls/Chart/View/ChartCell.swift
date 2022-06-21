//
//  ChartCell.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit
import SnapKit

final class ChartCell: UITableViewCell {
    
    static let id = String(describing: ChartCell.self)
    
    private let titleLabel = BaseLabel()
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

extension ChartCell {
    
    func update(article: SegmentViewModelResponse) {
        self.titleLabel.text = NumberConverter.toStringFrom(int: article.value)
        self.dateLabel.text = DateConverter.toStringFrom(date: article.date)
    }
}

private extension ChartCell {
    
    func configAppearance() {
        self.configTitleLabel()
        self.configDateLabel()
    }
    
    func configTitleLabel() {
        self.titleLabel.textColor = MainAttributs.color
    }
    
    func configDateLabel() {
        self.dateLabel.font = .systemFont(ofSize: 14)
        self.dateLabel.textColor = .lightGray
    }
    
    func makeConstraints() {
        self.makeDateLabelConstraints()
        self.makeTitleLabelConstraints()
    }
    
    func makeDateLabelConstraints() {
        self.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(120)
        }
    }
    
    func makeTitleLabelConstraints() {
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().inset(30)
            make.trailing.equalTo(self.dateLabel.snp.leading)
        }
    }
}
