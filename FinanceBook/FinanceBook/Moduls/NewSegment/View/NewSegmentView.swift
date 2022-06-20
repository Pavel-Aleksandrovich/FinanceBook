//
//  NewSegmentView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit
import SnapKit

enum ButtonState {
    case on
    case off
}

protocol INewSegmentView: AnyObject {
    var saveButtonTappedHandler: (() -> ())? { get set }
    
    func updateSaveButtonState(_ state: ButtonState)
    func getViewModel() -> ViewModelRequest
    func showErrorDateTextField()
    func showErrorCategoryNameTextField()
    func showErrorNumberTextField()
}

final class NewSegmentView: BaseView {
    
    private let saveButton = UIButton()
    private let datePicker = UIDatePicker()
    private let dateTextField = TextFieldView(settings:
            .init(header: "Date",
                  placeholder: "Enter Date"))
    private let numberTextField = TextFieldView(settings:
            .init(header: "Number",
                  placeholder: "Enter Sum"))
    private let categoryNameTextField = TextFieldView(settings:
            .init(header: "Type",
                  placeholder: "Enter Type"))
    private let categoryPicker = CategoryPicker()
    private let keyboardObserver = KeyboardObserver()
    
    var saveButtonTappedHandler: (() -> ())?
    var checkTextFieldsHandler: (() -> ())?
    
    override init() {
        super.init()
        self.configAppearance()
        self.makeConstraints()
        self.setHandlers()
    }
}

extension NewSegmentView: INewSegmentView {
    
    func updateSaveButtonState(_ state: ButtonState) {
        switch state {
        case .on:
            self.saveButton.alpha = 1
        case .off:
            self.saveButton.alpha = 0.2
        }
    }
    
    func getViewModel() -> ViewModelRequest {
        let date = self.dateTextField.text
        let color = TypeSection.allCases[self.categoryPicker.selectedRow(inComponent: 0)].color
        let amount = self.numberTextField.text
        let name = self.categoryNameTextField.text
        
        return ViewModelRequest(name: name,
                                amount: amount,
                                date: date,
                                color: color)
    }
    
    func showErrorDateTextField() {
        self.dateTextField.showShakeAnimation()
    }
    
    func showErrorCategoryNameTextField() {
        self.categoryNameTextField.showShakeAnimation()
    }
    
    func showErrorNumberTextField() {
        self.numberTextField.showShakeAnimation()
    }
}

private extension NewSegmentView {
    
    func configAppearance() {
        self.configView()
        self.configSaveButton()
        self.configDatePicker()
        self.configCategoryTextField()
        self.configNumberTextField()
        self.configDateTextField()
    }
    
    func configView() {
        self.backgroundColor = .white
    }
    
    func configSaveButton() {
        self.saveButton.alpha = 0.2
        self.saveButton.titleLabel?.text = "saveButton"
        self.saveButton.backgroundColor = .gray
        self.saveButton.layer.cornerRadius = 30
        self.saveButton.backgroundColor = MainAttributs.color
        self.saveButton.setTitle("Save", for: .normal)
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
    
    func configCategoryTextField() {
        self.categoryNameTextField.inputView = self.categoryPicker
        self.categoryNameTextField.addTarget(self,
                                             action: #selector(self.textFieldDidChange),
                                             for: .editingDidEnd)
    }
    
    func configNumberTextField() {
        self.numberTextField.keyboardType = .numberPad
        self.numberTextField.addTarget(self,
                                       action: #selector(self.textFieldDidChange),
                                       for: .editingChanged)
    }
    
    func configDateTextField() {
        self.dateTextField.inputView = self.datePicker
        self.dateTextField.addTarget(self,
                                     action: #selector(self.textFieldDidChange),
                                     for: .editingDidEnd)
    }
    
    @objc func textFieldDidChange() {
        self.checkTextFieldsHandler?()
    }
    
    func makeConstraints() {
        self.makeSaveButtonConstraints()
        self.makeDateTextFieldConstraints()
        self.makeNumberTextFieldConstraints()
        self.makeCategoryTextFieldConstraints()
    }
    
    func makeSaveButtonConstraints() {
        self.addSubview(self.saveButton)
        self.saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(60)
        }
    }
    
    func makeDateTextFieldConstraints() {
        self.addSubview(self.dateTextField)
        self.dateTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func makeNumberTextFieldConstraints() {
        self.addSubview(self.numberTextField)
        self.numberTextField.snp.makeConstraints { make in
            make.top.equalTo(self.dateTextField.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func makeCategoryTextFieldConstraints() {
        self.addSubview(self.categoryNameTextField)
        self.categoryNameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.numberTextField.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    func setHandlers() {
        self.setDateTextFieldToolbarHandler()
        self.setNumberTextFieldToolbarHandler()
        self.setCategoryTextFieldToolbarHandler()
        self.setKeyboardHandler()
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
    
    func setCategoryTextFieldToolbarHandler() {
        self.categoryNameTextField.onToolbarTappedHandler { [ weak self ] result in
            switch result {
            case .done:
                self?.categoryToolbarDoneButtonTapped()
            case .cancel: break
            }
        }
    }
    
    func dateToolbarDoneButtonTapped() {
        dateTextField.text = DateConverter.toStringFrom(date: datePicker.date)
    }
    
    func categoryToolbarDoneButtonTapped() {
        let name = TypeSection.allCases[self.categoryPicker.selectedRow(inComponent: 0)].name
        self.categoryNameTextField.text = name
    }
    
    func setKeyboardHandler() {
        self.keyboardObserver.addKeyboardObservers { result in
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
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(50)
        }
        self.configButtonAnimate()
    }
    
    func configButtonAnimate() {
        UIView.animate(withDuration: 0.25) {
            self.layoutIfNeeded()
        }
    }
}
