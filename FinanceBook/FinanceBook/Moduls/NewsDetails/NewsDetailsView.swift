//
//  File.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit
import SnapKit

protocol INewsDetailsView: AnyObject {
}

final class NewsDetailsView: UIView {
    
    private let titleLabel = BaseLabel()
    private let contentLabel = BaseLabel()
    private let imageView = UIImageView()
    private let scrollView = UIScrollView()
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.makeConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension NewsDetailsView {
    
    func makeConstraints() {
        self.addSubview()
        self.makeScrollViewConstraints()
        self.makeImageViewConstraints()
        self.makeTitleLabelConstraints()
        self.makeContentLabelConstraints()
    }
    
    func addSubview() {
        self.scrollView.addSubview(self.titleLabel)
        self.scrollView.addSubview(self.contentLabel)
        self.scrollView.addSubview(self.imageView)
        self.addSubview(self.scrollView)
    }
    
    func makeScrollViewConstraints() {
        self.scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func makeImageViewConstraints() {
        self.imageView.backgroundColor = .gray
        self.imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.scrollView).inset(10)
        }
    }
    
    func makeTitleLabelConstraints() {
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.imageView).inset(10)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func makeContentLabelConstraints() {
        self.contentLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel).inset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.scrollView)
        }
    }
}
