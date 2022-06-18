//
//  BaseLabel.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

final class BaseLabel: UILabel {
    
    init() {
        super.init(frame: .zero)
        self.numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
