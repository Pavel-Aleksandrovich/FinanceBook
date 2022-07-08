//
//  DateCell.swift
//  FinanceBook
//
//  Created by pavel mishanin on 07.07.2022.
//

import UIKit
import SnapKit

final class DateCell: UITableViewCell {
    
    private enum Constants {
        static let dateLabelFontSize: CGFloat = 14
        static let dateLabelWidth = 120
        
        static let amountLabelLeading = 30
    }
    
    static let id = String(describing: DateCell.self)
    
    private let tapGesture = UITapGestureRecognizer()
    private let datePicker = UIDatePicker()
    private let dateImageView = UIImageView()
    private let titleLabel = UILabel()
    private let dateTextField = UITextField()
    private let vStackView = UIStackView()
    
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

extension DateCell {}

// MARK: - Config Appearance
private extension DateCell {
    
    func configAppearance() {
        self.configView()
        self.configTapGesture()
        self.configDateImageView()
        self.configStackView()
        self.configTitleLabel()
        self.configDateTextField()
        self.configDatePicker()
    }
    
    func configView() {
        self.addGestureRecognizer(self.tapGesture)
    }
    
    func configTapGesture() {
        self.tapGesture.addTarget(self,
                                  action: #selector
                                  (self.textFieldDidChange))
    }
    
    @objc func textFieldDidChange() {
        self.dateTextField.becomeFirstResponder()
    }
    
    func configDateImageView() {
        self.dateImageView.image = UIImage(systemName: "calendar")
    }
    
    func configStackView() {
        self.vStackView.axis = .vertical
        self.vStackView.alignment = .leading
        self.vStackView.distribution = .fillProportionally
    }
    
    func configTitleLabel() {
        self.titleLabel.text = "titleLabel"
    }
    
    func configDateTextField() {
        self.setToolbar(textField: self.dateTextField)
        self.dateTextField.placeholder = "dateTextField"
        self.dateTextField.inputView = self.datePicker
        self.dateTextField.addTarget(self,
                                     action: #selector
                                     (self.textFieldEditingDidEnd),
                                     for: .editingDidEnd)
    }
    
    @objc func textFieldEditingDidEnd() {
        self.textFieldHandler?(self.dateTextField.text)
    }
    
    func configDatePicker() {
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.sizeToFit()
        self.datePicker.datePickerMode = .date
    }
}

// MARK: - Make Constraints
private extension DateCell {
    
    func makeConstraints() {
        self.makeDateImageViewConstraints()
        self.makeStackViewConstraints()
    }
    
    func makeDateImageViewConstraints() {
        self.addSubview(self.dateImageView)
        self.dateImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
            make.width.equalTo(self.dateImageView.snp.height)
        }
    }
    
    func makeStackViewConstraints() {
        self.addSubview(self.vStackView)
        self.vStackView.addArrangedSubview(self.titleLabel)
        self.vStackView.addArrangedSubview(self.dateTextField)
        
        self.vStackView.snp.makeConstraints { make in
            make.trailing.equalTo(self.dateImageView.snp.leading).inset(5)
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.equalToSuperview().inset(20)
        }
    }
}

private extension DateCell {
    
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
        self.dateTextField.text = self.converToStringFrom(date: self.datePicker.date)
        self.endEditing(true)
    }
    
    func converToStringFrom(date: Date) -> String {
        DateConverter.toStringFrom(date: date)
    }
}
