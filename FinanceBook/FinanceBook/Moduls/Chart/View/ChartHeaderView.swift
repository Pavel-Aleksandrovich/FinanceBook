//
//  ChartHeaderView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 18.06.2022.
//

import UIKit
import SnapKit

protocol ChartHeaderViewDelegate: AnyObject {
    func toggleSection(header: ChartHeaderView, section: Int)
}

final class ChartHeaderView: UITableViewHeaderFooterView {

    weak var delegate: ChartHeaderViewDelegate?
    private var section: Int?
    private let arrowLabel = UILabel()
    private let imageView = CategoryImageView()
    private let nameLabel = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer()
        self.configView()
        self.makeArrowLabelConstraints()
        self.makeImageViewConstraints()
        self.makeNameLabelConstraints()
        self.nameLabel.textColor = .white
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChartHeaderView {
    
    func setup(section: Int,
               chart: ChartDTO,
               delegate: ChartHeaderViewDelegate) {
        
        self.delegate = delegate
        self.section = section
        self.textLabel?.text = "\(chart.amount)"
        self.imageView.configImageView(chart: chart)
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

private extension ChartHeaderView {
    
    func configView() {
        self.textLabel?.textColor = .white
        self.contentView.backgroundColor = Main.color
    }
    
    func addGestureRecognizer() {
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector
                                             (self.selectHeaderAction))
        self.addGestureRecognizer(gesture)
    }
    
    @objc func selectHeaderAction(gesterRecognizer: UITapGestureRecognizer) {
        guard let cell = gesterRecognizer.view as? ChartHeaderView else { return }
        self.delegate?.toggleSection(header: self, section: cell.section!)
    }
    
    func makeArrowLabelConstraints() {
        self.arrowLabel.text = ">"
        self.arrowLabel.textColor = .white
        self.addSubview(self.arrowLabel)
        self.arrowLabel.snp.makeConstraints { make in
            make.bottom.top.equalToSuperview()
            make.trailing.equalToSuperview().inset(10)
            make.width.equalTo(12)
        }
    }
    
    func makeImageViewConstraints() {
        self.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(100)
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
