//
//  CategoryPicker.swift
//  FinanceBook
//
//  Created by pavel mishanin on 18.06.2022.
//

import UIKit

final class CategoryPicker: NSObject {
    
    private let pickerView = UIPickerView()
    private let toolbar = UIToolbar()
    private var font: TypeSection?
    private var size: CGFloat?
    private let textField: UITextField
    private weak var viewController: UIView?
    private let complitionHandler: (TypeSection) -> ()
    
//    private let fonts: [String] = TypeSection.allCases
    
    init(viewController: UIView, textField: UITextField,
         complitionHandler: @escaping (TypeSection) -> ()) {
        self.viewController = viewController
        self.textField = textField
        self.complitionHandler = complitionHandler
        super.init()
        configureAppearance()
        configureToolbar()
    }
    
    private func configureAppearance() {
        pickerView.delegate = self
        pickerView.dataSource = self
        
        textField.inputAccessoryView = toolbar
        textField.inputView = pickerView
        
        font = TypeSection.allCases.first
    }
    
    private func configureToolbar() {
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
        
        toolbar.sizeToFit()
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
    }
    
    @objc private func doneButtonTapped() {
        print("fee")
        guard let font = font else {return}
            complitionHandler(font)
        viewController?.endEditing(true)
    }
    
    @objc private func cancelButtonTapped() {
        viewController?.endEditing(true)
    }
}

extension CategoryPicker: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    numberOfRowsInComponent component: Int) -> Int {
        TypeSection.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return TypeSection.allCases[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        font = TypeSection.allCases[row]
    }
}
