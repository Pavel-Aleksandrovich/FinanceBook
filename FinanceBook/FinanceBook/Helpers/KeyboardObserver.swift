//
//  KeyboardObserver.swift
//  FinanceBook
//
//  Created by pavel mishanin on 20.06.2022.
//

import UIKit

final class KeyboardObserver {
    
    enum KeyboardState {
        case show(CGFloat)
        case hide
    }
    
    private var onKeyboardStateChangeHandler: ((KeyboardState) -> ())?
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func addKeyboardObservers(complition: @escaping(KeyboardState) -> ()) {
        self.onKeyboardStateChangeHandler = complition
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
}

private extension KeyboardObserver {
    
    @objc func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        guard let keyboardFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        let keyboardTop = keyboardFrame.height
        self.onKeyboardStateChangeHandler?(.show(keyboardTop))
    }
    
    @objc func keyboardWillHide() {
        self.onKeyboardStateChangeHandler?(.hide)
    }
}
