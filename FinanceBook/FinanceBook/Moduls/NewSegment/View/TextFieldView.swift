//
//  TextFieldView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 20.06.2022.
//

import UIKit

final class TextFieldView: UIView {
    
    struct Settings {
        let header: String
        let placeholder: String?
        
        init(header: String, placeholder: String? = nil) {
            self.header = header
            self.placeholder = placeholder
        }
    }
    
    private enum Constants {
        static let corner: CGFloat = 16
        static let emptyViewWidth = 16
        static let tfHeight = 40
        static let topOffset = 8
        static let borderWidth: CGFloat = 2
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
    private let textField = CustomTextField()
    
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

extension TextFieldView {
    
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

private extension TextFieldView {
    
    func configAppearance() {
        self.configHeaderLabel()
        self.configTextField()
    }
    
    func configHeaderLabel() {
        self.headerLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        self.headerLabel.text = "Start typing here"
        self.headerLabel.textColor = MainAttributs.color
    }
    
    func configTextField() {
        textField.layer.borderWidth = Constants.borderWidth
        textField.layer.borderColor = MainAttributs.color.cgColor
        textField.layer.cornerRadius = Constants.corner
        let emptyView = UIView(frame: .init(x: .zero,
                                            y: .zero,
                                            width: Constants.emptyViewWidth,
                                            height: .zero))
        textField.leftViewMode = .always
        textField.leftView = emptyView
        textField.rightViewMode = .always
        textField.rightView = emptyView
    }
    
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
            make.top.equalTo(self.headerLabel.snp.bottom).offset(Constants.topOffset)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(Constants.tfHeight)
        }
    }
    
    func configView(with settings: Settings) {
        self.headerLabel.text = settings.header
        self.textField.placeholder = settings.placeholder
    }
}
