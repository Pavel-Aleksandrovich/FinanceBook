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
    private let newsImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChartCell {
    
    func update(article: Segment) {
        self.titleLabel.text = article.name
    }
}

private extension ChartCell {
    
    func makeConstraints() {
        self.addSubview()
        self.makeTitleLabelConstraints()
    }
    
    func addSubview() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.newsImageView)
    }
    
    func makeNewsImageViewConstraints() {
        self.newsImageView.backgroundColor = .gray
        self.newsImageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(10)
            make.width.equalTo(self.newsImageView.snp.height)
        }
    }
    
    func makeTitleLabelConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
