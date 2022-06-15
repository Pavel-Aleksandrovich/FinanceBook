//
//  ListCompaniesCell.swift
//  Homework-10
//
//  Created by pavel mishanin on 08.06.2022.
//

import UIKit
import SnapKit

final class ListCompaniesCell: UITableViewCell {
    
    static let id = String(describing: ListCompaniesCell.self)
    
    private let titleLabel = UILabel()
    private let newsImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview()
        self.makeNewsImageViewConstraints()
        self.makeTitleLabelConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListCompaniesCell {
    
    func update(article: Article) {
        self.titleLabel.text = article.title
    }
    
    func setImage(data: Data) {
        self.newsImageView.image = UIImage(data: data)
    }
}

private extension ListCompaniesCell {
    
    func addSubview() {
        self.addSubview(titleLabel)
        self.addSubview(newsImageView)
    }
    
    func makeNewsImageViewConstraints() {
        newsImageView.backgroundColor = .gray
        self.newsImageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(10)
            make.width.equalTo(self.newsImageView.snp.height)
        }
    }
    
    func makeTitleLabelConstraints() {
        titleLabel.numberOfLines = 0
        self.titleLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(10)
            make.leading.equalTo(self.newsImageView.snp.trailing).inset(-10)
        }
    }
}
