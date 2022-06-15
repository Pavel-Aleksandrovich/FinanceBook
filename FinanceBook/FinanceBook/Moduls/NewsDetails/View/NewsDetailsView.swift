//
//  File.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit
import SnapKit

protocol INewsDetailsView: AnyObject {
    func update(article: Article)
    func setImage(data: Data)
}

final class NewsDetailsView: UIView {
    
    private let titleLabel = BaseLabel()
    private let contentLabel = BaseLabel()
    private let imageView = UIImageView()
    private let scrollView = UIScrollView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.makeConstraints()
        self.activityIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewsDetailsView: INewsDetailsView {
    
    func update(article: Article) {
        self.titleLabel.text = article.title
        self.contentLabel.text = article.content
    }
    
    func setImage(data: Data) {
        self.imageView.image = UIImage(data: data)
        self.activityIndicator.stopAnimating()
    }
}

private extension NewsDetailsView {
    
    func makeConstraints() {
        self.addSubview()
        self.makeScrollViewConstraints()
        self.makeImageViewConstraints()
        self.makeTitleLabelConstraints()
        self.makeContentLabelConstraints()
        self.makeActivityIndicatorConstraints()
    }
    
    func addSubview() {
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.titleLabel)
        self.scrollView.addSubview(self.contentLabel)
        self.scrollView.addSubview(self.imageView)
        self.scrollView.addSubview(self.activityIndicator)
    }
    
    func makeScrollViewConstraints() {
        self.scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func makeImageViewConstraints() {
        self.imageView.backgroundColor = .gray
        self.imageView.snp.makeConstraints { make in
            make.top.equalTo(self.scrollView).inset(10)
            make.leading.equalTo(self.snp.leading).inset(40)
            make.trailing.equalTo(self.snp.trailing).inset(40)
            make.height.equalTo(self.imageView.snp.width)
        }
    }
    
    func makeTitleLabelConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).inset(-10)
            make.leading.equalTo(self.snp.leading).inset(10)
            make.trailing.equalTo(self.snp.trailing).inset(10)
        }
    }
    
    func makeContentLabelConstraints() {
        self.contentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).inset(-10)
            make.leading.equalTo(self.snp.leading).inset(10)
            make.trailing.equalTo(self.snp.trailing).inset(10)
            make.bottom.equalTo(self.scrollView)
        }
    }
    
    func makeActivityIndicatorConstraints() {
        self.activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.imageView.snp.center)
        }
    }
}
