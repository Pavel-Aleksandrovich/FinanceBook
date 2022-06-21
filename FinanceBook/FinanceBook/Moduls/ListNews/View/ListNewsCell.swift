//
//  ListNewsCell.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit
import SnapKit

final class ListNewsCell: UITableViewCell {
    
    static let id = String(describing: ListNewsCell.self)
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let titleLabel = BaseLabel()
    private let newsImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.makeConstraints()
        self.activityIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListNewsCell {
    
    func update(article: Article) {
        self.titleLabel.text = article.title
    }
    
    func setImage(_ image: UIImage?) {
        self.newsImageView.image = image
        if self.newsImageView.image == nil {
            self.activityIndicator.startAnimating()
        } else {
            self.activityIndicator.stopAnimating()
        }
    }
}

private extension ListNewsCell {
    
    func makeConstraints() {
        self.makeNewsImageViewConstraints()
        self.makeTitleLabelConstraints()
        self.makeActivityIndicatorConstraints()
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
    
    func makeActivityIndicatorConstraints() {
        self.addSubview(self.activityIndicator)
        self.activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.newsImageView.snp.center)
        }
    }
}
