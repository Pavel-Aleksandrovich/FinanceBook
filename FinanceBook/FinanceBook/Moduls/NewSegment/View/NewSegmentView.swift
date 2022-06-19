//
//  NewSegmentView.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit
import SnapKit

protocol INewSegmentView: AnyObject {
    var saveButtonTappedHandler: ((Segment) -> ())? { get set }
}

final class NewSegmentView: BaseView {
    
    private let saveButton = UIButton()
    private let datePicker = UIDatePicker()
    private let dateTextField = CustomTextField()
    private let numberTextField = CustomTextField()
    private let categoryTextField = CustomTextField()
    private let categoryPicker = CategoryPicker()
    private let keyboardObserver = KeyboardObserver()
    var saveButtonTappedHandler: ((Segment) -> ())?
    
    override init() {
        super.init()
        self.configAppearance()
        self.makeConstraints()
        self.setHandlers()
    }
}

extension NewSegmentView: INewSegmentView {}

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
        self.saveButton.titleLabel?.text = "saveButton"
        self.saveButton.backgroundColor = .gray
        self.saveButton.layer.cornerRadius = 30
        self.saveButton.backgroundColor = MainAttributs.color
        self.saveButton.setTitle("Save", for: .normal)
        self.saveButton.setTitleColor(.white, for: .normal)
        self.saveButton.clipsToBounds = true
        self.saveButton.addTarget(self,
                                  action: #selector(saveButtonTapped),
                                  for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {
        let type = TypeSection.allCases[self.categoryPicker.selectedRow(inComponent: 0)]
        
        guard let dateString = self.dateTextField.text,
              let color = type.color,
              let amountString = self.numberTextField.text,
              let name = self.categoryTextField.text else { return }
        
        if let amount = Int(amountString),
           let date = self.getDateFrom(string: dateString),
           !name.isEmpty {
            
            let segment = Segment(name: name,
                                  color: color,
                                  amount: amount,
                                  date: date)
            self.saveButtonTappedHandler?(segment)
        }
    }
    
    func configDatePicker() {
        self.datePicker.preferredDatePickerStyle = .wheels
        self.datePicker.sizeToFit()
        self.datePicker.datePickerMode = .date
    }
    
    func configCategoryTextField() {
        self.categoryTextField.placeholder = "Choose Category"
        self.categoryTextField.inputView = categoryPicker
    }
    
    func configNumberTextField() {
        self.numberTextField.placeholder = "Enter Sum"
        self.numberTextField.keyboardType = .numberPad
    }
    
    func configDateTextField() {
        self.dateTextField.placeholder = "Choose Date"
        self.dateTextField.inputView = self.datePicker
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
        self.addSubview(self.categoryTextField)
        self.categoryTextField.snp.makeConstraints { make in
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
        self.categoryTextField.onToolbarTappedHandler { [ weak self ] result in
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
        self.categoryTextField.text = name
    }
    
    func getDateFrom(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yy"
        return dateFormatter.date(from: string)
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
