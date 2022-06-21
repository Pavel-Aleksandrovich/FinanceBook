//
//  FavoriteNewsCell.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit
import SnapKit

final class FavoriteNewsCell: UITableViewCell {
    
    static let id = String(describing: FavoriteNewsCell.self)
    
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

extension FavoriteNewsCell {
    
    func update(article: FavoriteNewsViewModel) {
        self.titleLabel.text = article.title
        self.newsImageView.image = UIImage(data: article.data)
    }
}

private extension FavoriteNewsCell {
    
    func makeConstraints() {
        self.makeNewsImageViewConstraints()
        self.makeTitleLabelConstraints()
    }
    
    func makeNewsImageViewConstraints() {
        self.addSubview(self.newsImageView)
        self.newsImageView.snp.makeConstraints { make in
            make.top.bottom.leading.equalToSuperview().inset(10)
            make.width.equalTo(self.newsImageView.snp.height)
        }
    }
    
    func makeTitleLabelConstraints() {
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview().inset(10)
            make.leading.equalTo(self.newsImageView.snp.trailing).inset(-10)
        }
    }
}
