//
//  ChartHeaderView.swift
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

    weak var delegate: HistoryHeaderViewDelegate?
    private var section: Int?
    
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
               chart: HistoryViewModel,
               delegate: HistoryHeaderViewDelegate) {
        
        self.delegate = delegate
        self.section = section
        self.amountLabel.text = NumberConverter.toStringFrom(int: Int(chart.amount))
        self.imageView.backgroundColor = ColorConverter.toColor(fromData: chart.color)
        self.nameLabel.text = chart.name
    }
    
    func setCollapsed(_ collapsed: Bool) {
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        animation.toValue = collapsed ? .pi / 2 : 0.0
        animation.duration = 0.2
        animation.isRemovedOnCompletion = false
        animation.fillMode = CAMediaTimingFillMode.forwards
        
        self.arrowLabel.layer.add(animation, forKey: nil)
    }
}

private extension HistoryHeaderView {
    
    func addGestureRecognizer() {
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector
                                             (self.selectHeaderAction))
        self.addGestureRecognizer(gesture)
    }
    
    @objc func selectHeaderAction(gesterRecognizer: UITapGestureRecognizer) {
        guard let cell = gesterRecognizer.view as? HistoryHeaderView,
              let section = cell.section else { return }
        self.delegate?.toggleSection(header: self, section: section)
    }
    
    func configAppearance() {
        self.configImageView()
        self.configAmountLabel()
        self.configNameLabel()
        self.configArrowLabel()
        self.configView()
    }
    
    func configImageView() {
        self.imageView.layer.cornerRadius = 20
    }
    
    func configAmountLabel() {
        self.amountLabel.textColor = .white
    }
    
    func configNameLabel() {
        self.nameLabel.textColor = .white
    }
    
    func configArrowLabel() {
        self.arrowLabel.text = ">"
        self.arrowLabel.textColor = .white
    }
    
    func configView() {
        self.contentView.backgroundColor = MainAttributs.color
    }
    
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
            make.trailing.equalToSuperview().inset(10)
            make.width.equalTo(12)
        }
    }
    
    func makeAmountLabelConstraints() {
        self.addSubview(self.amountLabel)
        self.amountLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(10)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(120)
        }
    }
    
    func makeImageViewConstraints() {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.leading.equalTo(self.amountLabel.snp.trailing)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }
    
    func makeNameLabelConstraints() {
        self.addSubview(self.nameLabel)
        self.nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.imageView.snp.trailing).inset(-10)
            make.top.bottom.equalToSuperview()
            make.trailing.equalTo(self.arrowLabel.snp.leading)
        }
    }
}
