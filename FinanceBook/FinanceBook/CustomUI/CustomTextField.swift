//
//  CustomLabel.swift
//  FinanceBook
//
//  Created by pavel mishanin on 19.06.2022.
//

import UIKit

final class CustomTextField: UITextField {
    
    enum Action {
        case done
        case cancel
    }
    
    private var tapHandler: ((Action) -> ())?
    
    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onToolbarTappedHandler(handler: @escaping(Action) -> ()) {
        self.tapHandler = handler
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
    
    @objc func cancelButtonTapped() {
        self.tapHandler?(.cancel)
        self.endEditing(true)
    }
    
    @objc func doneButtonTapped() {
        self.tapHandler?(.done)
        self.endEditing(true)
    }
}
