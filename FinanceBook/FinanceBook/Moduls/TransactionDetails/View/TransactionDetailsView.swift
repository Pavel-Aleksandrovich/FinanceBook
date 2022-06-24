//
//  NewSegmentView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit
import SnapKit

protocol ITransactionDetailsView: AnyObject {
    var saveButtonTappedHandler: (() -> ())? { get set }
    var checkTextFieldsHandler: (() -> ())? { get set }
    func updateSaveButtonState(_ state: Bool)
    func getViewModel() -> TransactionDetailsValidateRequest
    func showErrorDateTextField()
    func showErrorTransactionNameTextField()
    func showErrorNumberTextField()
}

final class TransactionDetailsView: BaseView {
    
    private enum Constants {
        static let dateTextFieldHeader = "Date"
        static let dateTextFieldPlaceholder = "Enter Date"
        static let dateTextFieldTop = 20
        static let dateTextFieldLeading = 20
        
        static let numberTextFieldHeader = "Number"
        static let numberTextFieldPlaceholder = "Enter Sum"
        static let numberTextFieldTop = -20
        static let numberTextFieldLeading = 20
        
        static let transactionNameTextFieldHeader = "Type"
        static let transactionNameTextFieldPlaceholder = "Enter Type"
        static let transactionNameTextFieldTop = -20
        static let transactionNameTextFieldLeading = 20
        
        static let saveButtonAlphaMax: CGFloat = 1
        static let saveButtonAlphaMin: CGFloat = 0.2
        static let saveButtonTitle = "Save"
        static let saveButtonCornerRadius: CGFloat = 30
        static let saveButtonBottom = 50
        static let saveButtonHeight = 60
        static let saveButtonLeading = 50
        
        static let duration: Double = 0.25
        
        static let component = 0
    }
    
    private let saveButton = UIButton()
    private let datePicker = UIDatePicker()
    private let dateTextField = TransactionDetailsTextFieldView(settings:
            .init(header: Constants.dateTextFieldHeader,
                  placeholder: Constants.dateTextFieldPlaceholder))
    private let numberTextField = TransactionDetailsTextFieldView(settings:
            .init(header: Constants.numberTextFieldHeader,
                  placeholder: Constants.numberTextFieldPlaceholder))
    private let transactionNameTextField = TransactionDetailsTextFieldView(settings:
            .init(header: Constants.transactionNameTextFieldHeader,
                  placeholder: Constants.transactionNameTextFieldPlaceholder))
    private let transactionPicker = TransactionDetailsPicker()
    private let keyboardObserver = KeyboardObserver()
    
    var saveButtonTappedHandler: (() -> ())?
    var checkTextFieldsHandler: (() -> ())?
    
    override init() {
        super.init()
        self.configAppearance()
        self.makeConstraints()
        self.setHandlers()
        self.setKeyboardObserver()
    }
}

// MARK: - ITransactionDetailsView
extension TransactionDetailsView: ITransactionDetailsView {
    
    func updateSaveButtonState(_ state: Bool) {
        switch state {
        case true:
            self.saveButton.alpha = Constants.saveButtonAlphaMax
        case false:
            self.saveButton.alpha = Constants.saveButtonAlphaMin
        }
    }
    
    func getViewModel() -> TransactionDetailsValidateRequest {
        let date = self.dateTextField.text
        let color = TransactionType.allCases[self.transactionPicker.selectedRow(inComponent: Constants.component)].color
        let amount = self.numberTextField.text
        let name = self.transactionNameTextField.text
        
        return TransactionDetailsValidateRequest(name: name,
                                                 amount: amount,
                                                 date: date,
                                                 color: color)
    }
    
    func showErrorDateTextField() {
        self.dateTextField.showShakeAnimation()
    }
    
    func showErrorTransactionNameTextField() {
        self.transactionNameTextField.showShakeAnimation()
    }
    
    func showErrorNumberTextField() {
        self.numberTextField.showShakeAnimation()
    }
}

// MARK: - Config Appearance
private extension TransactionDetailsView {
    
    func configAppearance() {
        self.configView()
        self.configSaveButton()
        self.configDatePicker()
        self.configTransactionNameTextField()
        self.configNumberTextField()
        self.configDateTextField()
    }
    
    func configView() {
        self.backgroundColor = .white
    }
    
    func configSaveButton() {
        self.saveButton.alpha = Constants.saveButtonAlphaMin
        self.saveButton.backgroundColor = .gray
        self.saveButton.layer.cornerRadius = Constants.saveButtonCornerRadius
        self.saveButton.backgroundColor = MainAttributs.color
        self.saveButton.setTitle(Constants.saveButtonTitle, for: .normal)
        self.saveButton.setTitleColor(.white, for: .normal)
        self.saveButton.clipsToBounds = true
        self.saveButton.addTarget(self,
                                  action: #selector(self.saveButtonTapped),
                                  for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {
        self.saveButtonTappedHandler?()
    }
    
    func configDatePicker() {
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.sizeToFit()
        self.datePicker.datePickerMode = .date
    }
    
    func configTransactionNameTextField() {
        self.transactionNameTextField.inputView = self.transactionPicker
        self.transactionNameTextField.addTarget(self,
                                                action: #selector
                                                (self.textFieldDidChange),
                                                for: .editingDidEnd)
    }
    
    func configNumberTextField() {
        self.numberTextField.keyboardType = .numberPad
        self.numberTextField.addTarget(self,
                                       action: #selector
                                       (self.textFieldDidChange),
                                       for: .editingChanged)
    }
    
    func configDateTextField() {
        self.dateTextField.inputView = self.datePicker
        self.dateTextField.addTarget(self,
                                     action: #selector
                                     (self.textFieldDidChange),
                                     for: .editingDidEnd)
    }
    
    @objc func textFieldDidChange() {
        self.checkTextFieldsHandler?()
    }
}

// MARK: - Make Constraints
private extension TransactionDetailsView {
    
    func makeConstraints() {
        self.makeSaveButtonConstraints()
        self.makeDateTextFieldConstraints()
        self.makeNumberTextFieldConstraints()
        self.makeCategoryTextFieldConstraints()
    }
    
    func makeSaveButtonConstraints() {
        self.addSubview(self.saveButton)
        self.saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
                .inset(Constants.saveButtonLeading)
            make.bottom.equalTo(self.safeAreaLayoutGuide)
                .inset(Constants.saveButtonBottom)
            make.height.equalTo(Constants.saveButtonHeight)
        }
    }
    
    func makeDateTextFieldConstraints() {
        self.addSubview(self.dateTextField)
        self.dateTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
                .inset(Constants.dateTextFieldTop)
            make.leading.trailing.equalToSuperview()
                .inset(Constants.dateTextFieldLeading)
        }
    }
    
    func makeNumberTextFieldConstraints() {
        self.addSubview(self.numberTextField)
        self.numberTextField.snp.makeConstraints { make in
            make.top.equalTo(self.dateTextField.snp.bottom)
                .inset(Constants.numberTextFieldTop)
            make.leading.trailing.equalToSuperview()
                .inset(Constants.numberTextFieldLeading)
        }
    }
    
    func makeCategoryTextFieldConstraints() {
        self.addSubview(self.transactionNameTextField)
        self.transactionNameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.numberTextField.snp.bottom).inset(Constants.transactionNameTextFieldTop)
            make.leading.trailing.equalToSuperview().inset(Constants.transactionNameTextFieldLeading)
        }
    }
}

// MARK: - Set Handlers
private extension TransactionDetailsView {
    
    func setHandlers() {
        self.setDateTextFieldToolbarHandler()
        self.setNumberTextFieldToolbarHandler()
        self.setTransactionToolbarHandler()
    }
    
    func setDateTextFieldToolbarHandler() {
        self.dateTextField.onToolbarTappedHandler { [ weak self ] result in
            switch result {
            case .done:
                self?.dateToolbarDoneButtonTapped()
            case .cancel: break
            }
        }
    }
    
    func setNumberTextFieldToolbarHandler() {
        self.numberTextField.onToolbarTappedHandler { [ weak self ] result in
            switch result {
            case .done: break
            case .cancel:
                self?.numberTextField.text = .none
            }
        }
    }
    
    func setTransactionToolbarHandler() {
        self.transactionNameTextField.onToolbarTappedHandler { [ weak self ] result in
            switch result {
            case .done:
                self?.transactionToolbarDoneButtonTapped()
            case .cancel: break
            }
        }
    }
    
    func dateToolbarDoneButtonTapped() {
        dateTextField.text = DateConverter.toStringFrom(date: datePicker.date)
    }
    
    func transactionToolbarDoneButtonTapped() {
        let name = TransactionType.allCases[self.transactionPicker.selectedRow(inComponent: Constants.component)].name
        self.transactionNameTextField.text = name
    }
}

// MARK: - Keyboard Observer
private extension TransactionDetailsView {
    
    func setKeyboardObserver() {
        self.keyboardObserver.addKeyboardObserver { result in
            switch result {
            case .show(let height):
                self.keyboardWillShow(height: height)
            case .hide:
                self.keyboardWillHide()
            }
        }
    }
    
    func keyboardWillShow(height: CGFloat) {
        self.saveButton.snp.updateConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(height)
        }
        self.configButtonAnimate()
    }
    
    func keyboardWillHide() {
        self.saveButton.snp.updateConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(Constants.saveButtonBottom)
        }
        self.configButtonAnimate()
    }
    
    func configButtonAnimate() {
        UIView.animate(withDuration: Constants.duration) {
            self.layoutIfNeeded()
        }
    }
}
