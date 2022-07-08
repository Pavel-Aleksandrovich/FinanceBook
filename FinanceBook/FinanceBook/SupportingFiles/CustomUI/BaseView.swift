//
//  BaseView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 19.06.2022.
//

import UIKit

class BaseView: UIView {
    
    init() {
        super.init(frame: .zero)
        self.hideKeyboardWhenTappedAround()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BaseView {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        self.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
}
