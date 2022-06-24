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
    
    private var onKeyboardStateChangedHandler: ((KeyboardState) -> ())?
    private let observer = NotificationCenter.default
    
    deinit {
        self.observer.removeObserver(self)
    }
}

extension KeyboardObserver {
    
    func addKeyboardObserver(complition: @escaping(KeyboardState) -> ()) {
        self.onKeyboardStateChangedHandler = complition
        
        self.observer.addObserver(self,
                                  selector: #selector(self.keyboardWillShow),
                                  name: UIResponder.keyboardWillShowNotification,
                                  object: nil)
        
        self.observer.addObserver(self,
                                  selector: #selector(self.keyboardWillHide),
                                  name: UIResponder.keyboardWillHideNotification,
                                  object: nil)
    }
}

private extension KeyboardObserver {
    
    @objc func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo
        guard let keyboardFrame = (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as?
                                   NSValue)?.cgRectValue else { return }
        
        let keyboardTop = keyboardFrame.height
        self.onKeyboardStateChangedHandler?(.show(keyboardTop))
    }
    
    @objc func keyboardWillHide() {
        self.onKeyboardStateChangedHandler?(.hide)
    }
}
