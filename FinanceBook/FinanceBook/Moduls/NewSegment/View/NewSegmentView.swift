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

final class NewSegmentView: UIView {
    
    var saveButtonTappedHandler: ((Segment) -> ())?
    private let saveButton = UIButton()
    private let dateTextField = UITextField()
    private let sumTextField = UITextField()
    private let categoryTextField = UITextField()
    private let toolbar = UIToolbar()
    private let datePicker = UIDatePicker()
    private var cPicker: CategoryPicker?
    private var type: TypeSection = .car
    
    init() {
        super.init(frame: .zero)
        self.backgroundColor = .white
        self.makeSaveButtonConstraints()
        self.configSaveButton()
        self.configLabels()
        configureAppearance()
        configureToolbar()
        
        cPicker = CategoryPicker(viewController: self,
                                     textField: categoryTextField) { type in
            print(type)
            self.type = type
            self.categoryTextField.text = type.rawValue
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NewSegmentView: INewSegmentView {}

private extension NewSegmentView {
    
    func configSaveButton() {
        self.saveButton.titleLabel?.text = "saveButton"
        self.saveButton.backgroundColor = .gray
        self.saveButton.addTarget(self,
                                  action: #selector(saveButtonTapped),
                                  for: .touchUpInside)
    }
    
    @objc func saveButtonTapped() {
        guard let dateString = self.dateTextField.text,
              let color = self.type.color,
              let amountString = self.sumTextField.text,
              let name = self.categoryTextField.text else { return }
        
        if let amount = Int(amountString),
           let date = self.getDateFrom(string: dateString) {
            
            let segment = Segment(name: name,
                                  color: color,
                                  amount: amount,
                                  date: date)
            self.saveButtonTappedHandler?(segment)
        }
        
    }
    
    func getDateFrom(string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.date(from: string)
    }
    
    func makeSaveButtonConstraints() {
        self.addSubview(self.saveButton)
        self.saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(50)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(50)
            make.height.equalTo(60)
        }
    }
    
    func configLabels() {
        self.addSubview(self.dateTextField)
        self.addSubview(self.sumTextField)
        self.addSubview(self.categoryTextField)
        
        self.dateTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        self.sumTextField.snp.makeConstraints { make in
            make.top.equalTo(self.dateTextField.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        self.categoryTextField.snp.makeConstraints { make in
            make.top.equalTo(self.sumTextField.snp.bottom).inset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        categoryTextField.placeholder = "Choose Category"
        sumTextField.placeholder = "Enter Sum"
        sumTextField.keyboardType = .numberPad
        dateTextField.placeholder = "Choose Date"
    }
    
    private func configureAppearance() {
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        datePicker.datePickerMode = .date
        
        dateTextField.inputAccessoryView = toolbar
        dateTextField.inputView = datePicker
    }
    
    private func configureToolbar() {
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .plain,
                                         target: self,
                                         action: #selector(doneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                          target: nil,
                                          action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel",
                                           style: .plain,
                                           target: self,
                                           action: #selector(cancelButtonTapped))
        
        toolbar.sizeToFit()
        toolbar.setItems([cancelButton, spaceButton, doneButton],
                         animated: false)
    }
    
    @objc private func doneButtonTapped() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        dateTextField.text = formatter.string(from: datePicker.date)
        self.endEditing(true)
    }
    
    @objc private func cancelButtonTapped() {
        self.endEditing(true)
    }
}
