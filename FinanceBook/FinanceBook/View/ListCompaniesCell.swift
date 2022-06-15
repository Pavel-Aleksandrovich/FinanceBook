//
//  ListCompaniesCell.swift
//  Homework-10
//
//  Created by pavel mishanin on 08.06.2022.
//

import UIKit
import SnapKit

final class ListCompaniesCell: UITableViewCell {
    
    private enum Constants {
        static let spacing: CGFloat = 5
    }
    
    static let id = String(describing: ListCompaniesCell.self)
    
    private let nameLabel = UILabel()
    private let countLabel = UILabel()
    private let vStackView = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview()
        self.makeStackViewConstraints()
        self.configStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ListCompaniesCell {
    
    func update(article: Article) {
        self.nameLabel.text = article.title
        self.countLabel.text = article.description
    }
}

private extension ListCompaniesCell {
    
    func addSubview() {
        self.addSubview(self.vStackView)
        self.vStackView.addArrangedSubview(self.nameLabel)
        self.vStackView.addArrangedSubview(self.countLabel)
    }
    
    func makeStackViewConstraints() {
        self.vStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configStackView() {
        self.vStackView.axis = .vertical
        self.vStackView.alignment = .center
        self.vStackView.distribution = .fill
        self.vStackView.spacing = Constants.spacing
    }
}
