//
//  DateView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 10.07.2022.
//

import UIKit

final class DateView: UIView {
    
    enum TapState {
        case leftArrow
        case rightArrow
        case dateLabel
    }
    
    private let dateLabel = UILabel()
    private let leftArrowImageView = UIImageView()
    private let rightArrowImageView = UIImageView()
    private let tapHandler: (TapState) -> ()
    
    init(completion: @escaping(TapState) -> ()) {
        self.tapHandler = completion
        super.init(frame: .zero)
        self.configAppearance()
        self.makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DateView {
    
    func setTitleForDateLabel(_ title: String) {
        self.dateLabel.text = title
    }
}

// MARK: - Actions
private extension DateView {
    
    @objc func leftArrowTapped() {
        self.tapHandler(.leftArrow)
    }
    
    @objc func rightArrowTapped() {
        self.tapHandler(.rightArrow)
    }
    
    @objc func dateLabelTapped() {
        self.tapHandler(.dateLabel)
    }
}

// MARK: - Config Appearance
private extension DateView {
    
    func configAppearance() {
        self.configLeftArrowImageView()
        self.configRightArrowImageView()
        self.configDateLabel()
    }
    
    func configLeftArrowImageView() {
        self.leftArrowImageView.image = UIImage(systemName: "arrow.left")
        self.leftArrowImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer()
        self.leftArrowImageView.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self,
                             action: #selector
                             (self.leftArrowTapped))
    }
    
    func configRightArrowImageView() {
        self.rightArrowImageView.image = UIImage(systemName: "arrow.right")
        self.rightArrowImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer()
        self.rightArrowImageView.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self,
                             action: #selector
                             (self.rightArrowTapped))
    }
    
    func configDateLabel() {
        self.dateLabel.text = "dateLabel.text.dateLabel"
        self.dateLabel.textAlignment = .center
        self.dateLabel.numberOfLines = 0
        self.dateLabel.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer()
        self.dateLabel.addGestureRecognizer(tapGesture)
        tapGesture.addTarget(self,
                             action: #selector
                             (self.dateLabelTapped))
    }
}

// MARK: - Make Constraints
private extension DateView {
    
    func makeConstraints() {
        self.makeDateLabelConstraints()
        self.makeLeftArrowImageViewConstraints()
        self.makeRightArrowImageViewConstraints()
        
    }
    
    func makeDateLabelConstraints() {
        self.addSubview(self.dateLabel)
        self.dateLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    func makeLeftArrowImageViewConstraints() {
        self.addSubview(self.leftArrowImageView)
        self.leftArrowImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.width.equalTo(self.leftArrowImageView.snp.height)
            make.trailing.equalTo(self.dateLabel.snp.leading).inset(-10)
        }
    }
    
    func makeRightArrowImageViewConstraints() {
        self.addSubview(self.rightArrowImageView)
        self.rightArrowImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.width.equalTo(self.rightArrowImageView.snp.height)
            make.leading.equalTo(self.dateLabel.snp.trailing).inset(-10)
        }
    }
}
