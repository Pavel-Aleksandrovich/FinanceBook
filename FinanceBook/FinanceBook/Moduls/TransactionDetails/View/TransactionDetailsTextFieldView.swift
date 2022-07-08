//
//  TextFieldView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 20.06.2022.
//

import UIKit

final class TransactionDetailsTextFieldView: UIView {
    
    struct Settings {
        let header: String
        let placeholder: String
        
        init(header: String, placeholder: String) {
            self.header = header
            self.placeholder = placeholder
        }
    }
    
    private enum Constants {
        static let textFieldCornerRadius: CGFloat = 16
        static let emptyViewWidth = 40
        static let textFieldHeight = 40
        static let textFieldTopOffset = 10
        static let textFieldBorderWidth: CGFloat = 2
        
        static let headerLabelFontSize: CGFloat = 18
    }
    
    public override var inputView: UIView? {
        get {
            return self.textField.inputView
        }
        set {
            self.textField.inputView = newValue
        }
    }
    
    public var keyboardType: UIKeyboardType {
        get {
            return self.textField.keyboardType
        }
        set {
            self.textField.keyboardType = newValue
        }
    }
    
    public var text: String? {
        get {
            return self.textField.text
        }
        set {
            self.textField.text = newValue
        }
    }
    
    private let headerLabel = UILabel()
    private let textField = BaseTextField()
    
    init(settings: Settings) {
        super.init(frame: .zero)
        self.makeConstraints()
        self.configAppearance()
        self.configView(with: settings)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TransactionDetailsTextFieldView {
    
    func addTarget(_ target: Any?,
                   action: Selector,
                   for controlEvents: UIControl.Event) {
        self.textField.addTarget(target,
                                 action: action,
                                 for: controlEvents)
    }
    
    func onToolbarTappedHandler(complition: @escaping (Action) -> ()) {
        self.textField.onToolbarTappedHandler(complition: complition)
    }
    
    func showShakeAnimation() {
        self.textField.createShakeAnimation()
    }
}

// MARK: - Config Appearance
private extension TransactionDetailsTextFieldView {
    
    func configView(with settings: Settings) {
        self.headerLabel.text = settings.header
        self.textField.placeholder = settings.placeholder
    }
    
    func configAppearance() {
        self.configHeaderLabel()
        self.configTextField()
    }
    
    func configHeaderLabel() {
        self.headerLabel.font = UIFont.systemFont(ofSize: Constants.headerLabelFontSize,
                                                  weight: .bold)
        self.headerLabel.textColor = MainAttributs.color
    }
    
    func configTextField() {
        self.textField.layer.borderWidth = Constants.textFieldBorderWidth
        self.textField.layer.borderColor = MainAttributs.color.cgColor
        self.textField.layer.cornerRadius = Constants.textFieldCornerRadius
        let emptyView = UIView(frame: .init(x: .zero,
                                            y: .zero,
                                            width: Constants.emptyViewWidth,
                                            height: .zero))
        self.textField.leftViewMode = .always
        self.textField.leftView = emptyView
        self.textField.rightViewMode = .always
        self.textField.rightView = emptyView
    }
}

// MARK: - Make Constraints
private extension TransactionDetailsTextFieldView {
    
    func makeConstraints() {
        self.makeHeaderLabelConstraints()
        self.makeTextFieldConstraints()
    }
    
    func makeHeaderLabelConstraints() {
        self.addSubview(self.headerLabel)
        self.headerLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
    }
    
    func makeTextFieldConstraints() {
        self.addSubview(self.textField)
        self.textField.snp.makeConstraints { make in
            make.top.equalTo(self.headerLabel.snp.bottom)
                .offset(Constants.textFieldTopOffset)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(Constants.textFieldHeight)
        }
    }
}
