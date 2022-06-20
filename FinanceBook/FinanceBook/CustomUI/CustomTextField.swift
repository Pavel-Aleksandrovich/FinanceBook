//
//  CustomLabel.swift
//  FinanceBook
//
//  Created by pavel mishanin on 19.06.2022.
//

import UIKit

enum Action {
    case done
    case cancel
}

final class CustomTextField: UITextField {
    
    private var tapHandler: ((Action) -> ())?
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomTextField {
    
    func onToolbarTappedHandler(complition: @escaping(Action) -> ()) {
        self.tapHandler = complition
        let toolbar = UIToolbar()
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector
                                         (self.doneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                          target: nil,
                                          action: nil)
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel,
                                           target: self,
                                           action: #selector
                                           (self.cancelButtonTapped))
        
        cancelButton.tintColor = MainAttributs.color
        doneButton.tintColor = MainAttributs.color
        toolbar.sizeToFit()
        toolbar.setItems([cancelButton, spaceButton, doneButton],
                         animated: false)
        self.inputAccessoryView = toolbar
    }
    
    func createShakeAnimation() {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "position.x")
        shakeAnimation.values = [0, -15, 15, -15, 15, 0]
        shakeAnimation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
        shakeAnimation.duration = 0.4
        shakeAnimation.isAdditive = true
        self.layer.add(shakeAnimation, forKey: nil)
    }
}

private extension CustomTextField {
    @objc func cancelButtonTapped() {
        self.tapHandler?(.cancel)
        self.endEditing(true)
    }
    
    @objc func doneButtonTapped() {
        self.tapHandler?(.done)
        self.endEditing(true)
    }
}
