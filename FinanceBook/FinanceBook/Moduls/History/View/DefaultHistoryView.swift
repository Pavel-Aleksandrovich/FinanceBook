//
//  DefaultHistoryView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 24.06.2022.
//

import UIKit

final class DefaultHistoryView: UIView {
    
    private enum Constants {
        static let defaultViewImageName = "arrow"
        static let defaultViewTop = 50
        static let defaultViewHeight = 120
        static let defaultViewWidth = 150
        
        static let textLabelText = "Add your first transaction"
        static let textLabelNumberOfLines = 0
        static let textLabelFontSize: CGFloat = 40
        static let textLabelTop = -50
        static let textLabelLeading = 50
    }
    
    private let defaultView = UIImageView()
    private let textLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        self.configAppearance()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension DefaultHistoryView {
    
    func configAppearance() {
        self.configDefaultView()
        self.configTextLabel()
    }
    
    func configDefaultView() {
        self.defaultView.image = UIImage(named: Constants.defaultViewImageName)
    }
    
    func configTextLabel() {
        self.textLabel.text = Constants.textLabelText
        self.textLabel.textAlignment = .center
        self.textLabel.numberOfLines = Constants.textLabelNumberOfLines
        self.textLabel.font = UIFont.systemFont(ofSize: Constants.textLabelFontSize)
    }
    
    func makeConstraints() {
        self.makeDefaultViewConstraints()
        self.makeTextLabelConstraints()
    }
    
    func makeDefaultViewConstraints() {
        self.addSubview(self.defaultView)
        self.defaultView.snp.makeConstraints { make in
            make.top.trailing.equalTo(self.safeAreaLayoutGuide)
                .inset(Constants.defaultViewTop)
            make.height.equalTo(Constants.defaultViewHeight)
            make.width.equalTo(Constants.defaultViewWidth)
        }
    }
    
    func makeTextLabelConstraints() {
        self.addSubview(self.textLabel)
        self.textLabel.snp.makeConstraints { make in
            make.top.equalTo(self.defaultView.snp.bottom)
                .inset(Constants.textLabelTop)
            make.leading.trailing.equalToSuperview()
                .inset(Constants.textLabelLeading)
        }
    }
}
