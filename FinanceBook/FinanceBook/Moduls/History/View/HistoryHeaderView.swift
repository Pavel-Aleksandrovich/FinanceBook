//
//  HistoryHeaderView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 18.06.2022.
//

import UIKit
import SnapKit

protocol HistoryHeaderViewDelegate: AnyObject {
    func toggleSection(header: HistoryHeaderView, section: Int)
}

final class HistoryHeaderView: UITableViewHeaderFooterView {
    
    private enum Constants {
        static let animationDuration: CFTimeInterval = 0.2
        static let animationFalse = 0.0
        static let animationTrue = Double.pi/2
        static let animationKeyPath = "transform.rotation"
        
        static let imageViewCornerRadius: CGFloat = 20
        static let imageViewWidth = 40
        
        static let arrowLabelText = ">"
        static let arrowLabelTrailing = 10
        static let arrowLabelWidth = 12
        
        static let nameLabelLeading = -10
        
        static let amountLabelWidth = 120
        static let amountLabelLeading = 10
    }
    
    weak var delegate: HistoryHeaderViewDelegate?
    
    private var section = Int()
    
    private let arrowLabel = UILabel()
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    private let amountLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer()
        self.configAppearance()
        self.makeConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HistoryHeaderView {
    
    func setup(section: Int,
               history: HistoryViewModel,
               delegate: HistoryHeaderViewDelegate) {
        
        self.delegate = delegate
        self.section = section
        self.amountLabel.text = NumberConverter.toStringFrom(int: Int(history.amount))
        self.imageView.backgroundColor = ColorConverter.toColor(fromData: history.color)
        self.nameLabel.text = history.name
    }
    
    func setCollapsed(_ collapsed: Bool) {
        let animation = CABasicAnimation(keyPath: Constants.animationKeyPath)
        
        switch collapsed {
        case true:
            animation.toValue = Constants.animationTrue
        case false:
            animation.toValue = Constants.animationFalse
        }
        
        animation.duration = Constants.animationDuration
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.arrowLabel.layer.add(animation, forKey: nil)
    }
}

// MARK: - Gesture Recognizer
private extension HistoryHeaderView {
    
    func addGestureRecognizer() {
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector
                                             (self.selectHeaderAction))
        self.addGestureRecognizer(gesture)
    }
    
    @objc func selectHeaderAction(gesterRecognizer: UITapGestureRecognizer) {
        guard let cell = gesterRecognizer.view as? HistoryHeaderView
        else { return }
        self.delegate?.toggleSection(header: self, section: cell.section)
    }
}

// MARK: - Config Appearance
private extension HistoryHeaderView {
    
    func configAppearance() {
        self.configImageView()
        self.configAmountLabel()
        self.configNameLabel()
        self.configArrowLabel()
        self.configView()
    }
    
    func configImageView() {
        self.imageView.layer.cornerRadius = Constants.imageViewCornerRadius
    }
    
    func configAmountLabel() {
        self.amountLabel.textColor = .white
    }
    
    func configNameLabel() {
        self.nameLabel.textColor = .white
    }
    
    func configArrowLabel() {
        self.arrowLabel.text = Constants.arrowLabelText
        self.arrowLabel.textColor = .white
    }
    
    func configView() {
        self.contentView.backgroundColor = MainAttributs.color
    }
}

// MARK: - Make Constraints
private extension HistoryHeaderView {
    
    func makeConstraints() {
        self.makeArrowLabelConstraints()
        self.makeAmountLabelConstraints()
        self.makeImageViewConstraints()
        self.makeNameLabelConstraints()
    }
    
    func makeArrowLabelConstraints() {
        self.addSubview(self.arrowLabel)
        self.arrowLabel.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(Constants.arrowLabelTrailing)
            make.width.equalTo(Constants.arrowLabelWidth)
        }
    }
    
    func makeAmountLabelConstraints() {
        self.addSubview(self.amountLabel)
        self.amountLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(Constants.amountLabelLeading)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(Constants.amountLabelWidth)
        }
    }
    
    func makeImageViewConstraints() {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.leading.equalTo(self.amountLabel.snp.trailing)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(Constants.imageViewWidth)
        }
    }
    
    func makeNameLabelConstraints() {
        self.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.imageView.snp.trailing)
                .inset(Constants.nameLabelLeading)
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(self.arrowLabel.snp.leading)
        }
    }
}
