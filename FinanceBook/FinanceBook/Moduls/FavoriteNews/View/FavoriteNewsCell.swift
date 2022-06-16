//
//  FavoriteNewsCell.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit
import SnapKit

protocol FavoriteNewsCellDelegate: AnyObject {
    func load(url: String?, complition: @escaping(Data) -> ())
}

final class FavoriteNewsCell: UITableViewCell {
    
    static let id = String(describing: FavoriteNewsCell.self)
    
    weak var delegate: FavoriteNewsCellDelegate?
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let titleLabel = BaseLabel()
    private let newsImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.makeConstraints()
        self.activityIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoriteNewsCell {
    
    func update(article: Article) {
        self.titleLabel.text = article.title
//        delegate?.load(url: article.urlToImage) { data in
//            self.setImage(data: data)
//        }
    }
    
    func setImage(data: Data) {
        self.activityIndicator.startAnimating()
        self.newsImageView.image = UIImage(data: data)
        if self.newsImageView.image != nil {
            self.activityIndicator.stopAnimating()
        }
    }
}

private extension FavoriteNewsCell {
    
    func makeConstraints() {
        self.addSubview()
        self.makeNewsImageViewConstraints()
        self.makeTitleLabelConstraints()
        self.makeTitleLabelConstraints()
        self.makeActivityIndicatorConstraints()
    }
    
    func addSubview() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.newsImageView)
        self.newsImageView.addSubview(self.activityIndicator)
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
            make.top.bottom.trailing.equalToSuperview().inset(10)
            make.leading.equalTo(self.newsImageView.snp.trailing).inset(-10)
        }
    }
    
    func makeActivityIndicatorConstraints() {
        self.activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.newsImageView.snp.center)
        }
    }
}
