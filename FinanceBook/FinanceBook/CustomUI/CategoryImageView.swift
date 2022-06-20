//
//  CategoryImageView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 18.06.2022.
//

import UIKit

final class CategoryImageView: UIImageView {
    
    private enum Constants {
        static let cornerRadius: CGFloat = 20
        static let imageViewWidth = 20
    }
    
    private let imageView = UIImageView()
    
    init() {
        super.init(frame: .zero)
        self.configView()
        self.makeImageViewConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryImageView {
    
    func configImageView(chart: ChartViewModelResponse) {
        self.imageView.image = UIImage(named: chart.name)
        self.backgroundColor = ColorConverter.toColor(fromData: chart.color)
    }
}

private extension CategoryImageView {
    
    func configView() {
        self.backgroundColor = .red
        self.layer.cornerRadius = Constants.cornerRadius
        self.clipsToBounds = true
    }
    
    func makeImageViewConstraints() {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.center.equalTo(self)
            make.width.height.equalTo(Constants.imageViewWidth)
        }
    }
}
