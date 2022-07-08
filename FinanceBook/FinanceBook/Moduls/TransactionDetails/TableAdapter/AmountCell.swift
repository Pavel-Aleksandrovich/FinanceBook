//
//  AmountCell.swift
//  FinanceBook
//
//  Created by pavel mishanin on 07.07.2022.
//

import UIKit
import SnapKit

final class AmountCell: UITableViewCell {
    
    private enum Constants {
        static let dateLabelFontSize: CGFloat = 14
        static let dateLabelWidth = 120
        
        static let amountLabelLeading = 30
    }
    
    static let id = String(describing: AmountCell.self)
    
    private let titleLabel = UILabel()
    private let textField = UITextField()
    private let tapGesture = UITapGestureRecognizer()
    
    var textFieldHandler: ((String?) -> ())?
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.makeConstraints()
        self.configAppearance()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AmountCell {}

// MARK: - Config Appearance
private extension AmountCell {
    
    func configAppearance() {
        self.configTextField()
        self.configView()
        self.configTapGesture()
        self.configTitleLabel()
    }
    
    func configView() {
        self.addGestureRecognizer(self.tapGesture)
    }
    
    func configTapGesture() {
        self.tapGesture.addTarget(self,
                                  action: #selector
                                  (self.textFieldDidChange))
    }
    
    func configTextField() {
        self.setToolbar(textField: self.textField)
        self.textField.placeholder = "textField.placeholder"
        self.textField.keyboardType = .numberPad
        self.textField.addTarget(self,
                                 action: #selector
                                 (self.textFieldEditingChanged),
                                 for: .editingChanged)
    }
    
    @objc func textFieldEditingChanged() {
        self.textFieldHandler?(self.textField.text)
    }
    
    @objc func textFieldDidChange() {
        self.textField.becomeFirstResponder()
    }
    
    func configTitleLabel() {
        self.titleLabel.text = "Amount"
    }
}

// MARK: - Make Constraints
private extension AmountCell {
    
    func makeConstraints() {
        self.makeTextFieldConstraints()
        self.makeTitleLabelConstraints()
    }
    
    func makeTextFieldConstraints() {
        self.addSubview(self.textField)
        self.textField.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func makeTitleLabelConstraints() {
        self.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(self.textField.snp.top).inset(10)
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
}

private extension AmountCell {
    
    func setToolbar(textField: UITextField) {
        
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
        textField.inputAccessoryView = toolbar
    }
    
    @objc func cancelButtonTapped() {
        self.endEditing(true)
    }
    
    @objc func doneButtonTapped() {
        self.endEditing(true)
    }
}
