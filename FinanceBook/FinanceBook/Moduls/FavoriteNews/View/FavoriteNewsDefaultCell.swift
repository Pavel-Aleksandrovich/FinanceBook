//
//  FavoriteNewsDefaultCell.swift
//  FinanceBook
//
//  Created by pavel mishanin on 21.06.2022.
//

import UIKit
import SnapKit

final class FavoriteNewsDefaultCell: UITableViewCell {
    
    private enum Constants {
        static let defaultLabelText = "You haven't added news to favorite yet"
        static let defaultLabelTop = 20
        static let defaultLabelLeading = 50
        
        static let defaultImageName = "bookmark"
        static let defaultImageViewMultiplied = 0.5
        static let defaultImageViewTop = -20
    }
    
    static let id = String(describing: FavoriteNewsDefaultCell.self)
    
    private let defaultLabel = BaseLabel()
    private let defaultImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.makeConstraints()
        self.configAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FavoriteNewsDefaultCell {
    
    func configAppearance() {
        self.configDefaultLabel()
        self.configDefaultImageView()
    }
    
    func configDefaultLabel() {
        self.defaultLabel.textAlignment = .center
        self.defaultLabel.text = Constants.defaultLabelText
    }
    
    func configDefaultImageView() {
        self.defaultImageView.contentMode = .scaleAspectFit
        self.defaultImageView.image = UIImage(systemName: Constants.defaultImageName)
        self.defaultImageView.tintColor = MainAttributs.color
    }
    
    func makeConstraints() {
        self.makeDefaultLabelConstraints()
        self.makeDefaultImageViewConstraints()
    }
    
    func makeDefaultLabelConstraints() {
        self.addSubview(self.defaultLabel)
        self.defaultLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
                .inset(Constants.defaultLabelTop)
            make.leading.trailing.equalToSuperview()
                .inset(Constants.defaultLabelLeading)
        }
    }
    
    func makeDefaultImageViewConstraints() {
        self.addSubview(self.defaultImageView)
        self.defaultImageView.snp.makeConstraints { make in
            make.top.equalTo(self.defaultLabel.snp.bottom)
                .inset(Constants.defaultImageViewTop)
            make.leading.trailing.equalToSuperview()
            make.height.equalToSuperview()
                .multipliedBy(Constants.defaultImageViewMultiplied)
        }
    }
}
