//
//  File.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit
import SnapKit

protocol INewsDetailsView: AnyObject {
    var onFavoriteButtonTappedHandler: (() -> ())? { get set }
    func update(article: NewsRequest)
    func setImage(data: UIImage?)
    func getModel() -> NewsDetailsRequest?
}

final class NewsDetailsView: UIView {
    
    private let titleLabel = BaseLabel()
    private let contentLabel = BaseLabel()
    private let imageView = UIImageView()
    private let scrollView = UIScrollView()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let favoriteView = UIImageView()
    
    var onFavoriteButtonTappedHandler: (() -> ())?
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.makeConstraints()
        self.configFavoriteView()
        self.activityIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewsDetailsView: INewsDetailsView {
    
    func update(article: NewsRequest) {
        self.titleLabel.text = article.title
        self.contentLabel.text = article.desctiption
    }
    
    func setImage(data: UIImage?) {
        self.imageView.image = data
        self.activityIndicator.stopAnimating()
    }
    
    func getModel() -> NewsDetailsRequest? {
        guard let title = titleLabel.text,
              let description = contentLabel.text,
              let image = self.imageView.image?.pngData()
        else { return nil }
        
        return NewsDetailsRequest(title: title,
                           desctiption: description,
                           imageData: image)
    }
}

private extension NewsDetailsView {
    
    func configFavoriteView() {
        self.favoriteView.image = UIImage(systemName: "heart")
        self.favoriteView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(self.handleTap))
        self.favoriteView.addGestureRecognizer(tap)
    }
    
    @objc func handleTap() {
        self.onFavoriteButtonTappedHandler?()
    }
    
    func makeConstraints() {
        self.addSubview()
        self.makeScrollViewConstraints()
        self.makeImageViewConstraints()
        self.makeFavoriteViewConstraints()
        self.makeTitleLabelConstraints()
        self.makeContentLabelConstraints()
        self.makeActivityIndicatorConstraints()
    }
    
    func addSubview() {
        self.addSubview(self.scrollView)
        self.scrollView.addSubview(self.titleLabel)
        self.scrollView.addSubview(self.contentLabel)
        self.scrollView.addSubview(self.imageView)
        self.scrollView.addSubview(self.favoriteView)
        self.scrollView.addSubview(self.activityIndicator)
    }
    
    func makeScrollViewConstraints() {
        self.scrollView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    func makeImageViewConstraints() {
        self.imageView.snp.makeConstraints { make in
            make.top.equalTo(self.scrollView).inset(10)
            make.leading.equalTo(self.snp.leading).inset(40)
            make.trailing.equalTo(self.snp.trailing).inset(40)
            make.height.equalTo(self.imageView.snp.width)
        }
    }
    
    func makeFavoriteViewConstraints() {
        self.favoriteView.snp.makeConstraints { make in
            make.top.equalTo(self.imageView.snp.bottom).inset(-10)
            make.width.height.equalTo(100)
            make.centerX.equalTo(self.snp.centerX)
        }
    }
    
    func makeTitleLabelConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.favoriteView.snp.bottom).inset(-10)
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
