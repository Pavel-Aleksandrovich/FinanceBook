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
    private let networkManager = NetworkManager()
    
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
        self.setImage(url: article.urlToImage)
    }
    
    func setImage(url: String?) {
        self.activityIndicator.startAnimating()
//        self.newsImageView.image = UIImage(data: data)
        guard let url = url else { return }

        self.networkManager.loadImageDataFrom(url: url) { result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.newsImageView.image = image
                }
            case .failure(_): break
            }
        }
        if self.newsImageView.image != nil {
            self.activityIndicator.stopAnimating()
        }
    }
}

private extension ListNewsCell {
    
    func makeConstraints() {
        self.addSubview()
        self.makeNewsImageViewConstraints()
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
