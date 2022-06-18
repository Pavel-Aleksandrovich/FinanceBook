//
//  ChartHeaderView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 18.06.2022.
//

import UIKit

protocol ChartHeaderViewDelegate: AnyObject {
    func toggleSection(header: ChartHeaderView, section: Int)
}

final class ChartHeaderView: UITableViewHeaderFooterView {

    weak var delegate: ChartHeaderViewDelegate?
    private var section: Int?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer()
        self.configView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ChartHeaderView {
    
    func setup(withTitle title: String,
               section: Int,
               delegate: ChartHeaderViewDelegate) {
        
        self.delegate = delegate
        self.section = section
        self.textLabel?.text = title
    }
}

private extension ChartHeaderView {
    
    func configView() {
        self.textLabel?.textColor = .white
        self.contentView.backgroundColor = .lightGray
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
}
