//
//  FavoriteNewsDefaultCell.swift
//  FinanceBook
//
//  Created by pavel mishanin on 21.06.2022.
//

import UIKit
import SnapKit

final class FavoriteNewsDefaultCell: UITableViewCell {
    
    static let id = String(describing: FavoriteNewsDefaultCell.self)
    
    private let defaultLabel = BaseLabel()
    private let defaultImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.makeConstraints()
        self.defaultLabel.textAlignment = .center
        self.defaultImageView.contentMode = .scaleAspectFit
        showDefaultImage()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoriteNewsDefaultCell {
    
    func showDefaultImage() {
        self.defaultLabel.text = "Favorite News is Empty"
        self.defaultImageView.image = UIImage(systemName: "bookmark")
    }
}

private extension FavoriteNewsDefaultCell {
    
    func makeConstraints() {
        self.makeNewsImageViewConstraints()
        self.makeTitleLabelConstraints()
    }
    
    func makeNewsImageViewConstraints() {
        self.addSubview(self.defaultImageView)
        self.defaultImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func makeTitleLabelConstraints() {
        self.addSubview(self.defaultLabel)
        self.defaultLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(50)
        }
    }
}
