//
//  NewsDetailsButtonView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 23.06.2022.
//

import UIKit

final class NewsDetailsFavoriteView: UIView {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 10
        static let borderWidth: CGFloat = 3
        
        static let textLabelText = "Add"
        static let textLabelFontSize: CGFloat = 22
        static let textLabelLeading = -15
        static let textLabelTop = 10
        
        static let plusImageViewImageName = "plus"
        static let plusImageViewTop = 10
    }
    
    private let textLabel = UILabel()
    private let plusImageView = UIImageView()
    
    private var tapHandler: (() -> ())?
    
    init() {
        super.init(frame: .zero)
        self.configAppearance()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewsDetailsFavoriteView {
    
    func setTappedHandler(complition: @escaping() -> ()) {
        self.tapHandler = complition
    }
}

private extension NewsDetailsFavoriteView {
    
    func configAppearance() {
        self.configView()
        self.configPlusImageView()
        self.configTextLabel()
    }
    
    func configView() {
        self.layer.cornerRadius = Constants.cornerRadius
        self.layer.borderWidth = Constants.borderWidth
        self.layer.borderColor = UIColor.gray.cgColor
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(self.onViewTapped))
        self.addGestureRecognizer(tap)
    }
    
    @objc func onViewTapped() {
        self.tapHandler?()
    }
    
    func configPlusImageView() {
        self.plusImageView.image = UIImage(systemName: Constants.plusImageViewImageName)
    }
    
    func configTextLabel() {
        self.textLabel.text = Constants.textLabelText
        self.textLabel.font = .systemFont(ofSize: Constants.textLabelFontSize)
    }
}

private extension NewsDetailsFavoriteView {
    
    func makeConstraints() {
        self.makePlusImageViewConstraints()
        self.makeTextLabelConstraints()
    }
    
    func makePlusImageViewConstraints() {
        self.addSubview(self.plusImageView)
        self.plusImageView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview().inset(Constants.plusImageViewTop)
            make.width.equalTo(self.plusImageView.snp.height)
        }
    }
    
    func makeTextLabelConstraints() {
        self.addSubview(self.textLabel)
        self.textLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.plusImageView.snp.trailing)
                .inset(Constants.textLabelLeading)
            make.top.bottom.trailing.equalToSuperview().inset(Constants.textLabelTop)
        }
    }
}
