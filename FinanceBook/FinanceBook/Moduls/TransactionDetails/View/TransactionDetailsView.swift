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
    var textFieldChangeHandler: (() -> ())? { get set }
    func updateSaveButtonState(_ state: Bool)
    func getViewModel() -> HistoryValidateRequest
    func setCategory(_ model: CategoryType)
    func showShakeAnimation()
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
    private let keyboardObserver = KeyboardObserver()
    private let tableView = UITableView()
    private let tableAdapter = TransactionDetailsTableAdapter()
    
    var saveButtonTappedHandler: (() -> ())?
    var textFieldChangeHandler: (() -> ())?
    var onCellTappedHandler: ((TransactionDetailsTableAdapter.CellType) -> ())?
    
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
    
    func getViewModel() -> HistoryValidateRequest {
        
        let date = self.tableAdapter.selectedDate
        let color = self.tableAdapter.selectedCategory?.color
        let amount = self.tableAdapter.selectedAmount
        let name = self.tableAdapter.selectedCategory?.name
        let profit = self.tableAdapter.selectedCategory?.profit
        
        return HistoryValidateRequest(name: name,
                                      amount: amount,
                                      date: date,
                                      color: color,
                                      profit: profit)
//        return TransactionDetailsValidateRequest(name: name,
//                                                 amount: amount,
//                                                 date: date,
//                                                 color: color)
    }
    
    func setCategory(_ model: CategoryType) {
        self.tableAdapter.selectedCategory = model
        self.tableView.reloadData()
    }
    
    func showShakeAnimation() {
        self.createShakeAnimation()
    }
}

// MARK: - Config Appearance
private extension TransactionDetailsView {
    
    func configAppearance() {
        self.configView()
        self.configSaveButton()
        self.configDatePicker()
        self.configTableView()
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
    
    func configTableView() {
        self.tableView.delegate = self.tableAdapter
        self.tableView.dataSource = self.tableAdapter
        self.tableView.register(CategoryCell.self,
                                forCellReuseIdentifier: CategoryCell.id)
        self.tableView.register(AmountCell.self,
                                forCellReuseIdentifier: AmountCell.id)
        self.tableView.register(DateCell.self,
                                forCellReuseIdentifier: DateCell.id)
    }
}

// MARK: - Make Constraints
private extension TransactionDetailsView {
    
    func makeConstraints() {
        self.makeSaveButtonConstraints()
        self.makeTableViewConstraints()
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
    
    func makeTableViewConstraints() {
        self.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self.saveButton.snp.top).inset(-10)
        }
    }
}

// MARK: - Set Handlers
private extension TransactionDetailsView {
    
    func setHandlers() {
        self.setOnCellTappedHandler()
        self.setTextFieldChangeHandler()
    }
    
    func setOnCellTappedHandler() {
        self.tableAdapter.onCellTappedHandler = { type in
            self.onCellTappedHandler?(type)
        }
    }
    
    func setTextFieldChangeHandler() {
        self.tableAdapter.textFieldChangeHandler = {
            self.textFieldChangeHandler?()
        }
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

private extension TransactionDetailsView {
    
    func createShakeAnimation() {
        let shakeAnimation = CAKeyframeAnimation(keyPath: "position.x")
        shakeAnimation.values = [0, -15, 15, -15, 15, 0]
        shakeAnimation.keyTimes = [0, 0.2, 0.4, 0.6, 0.8, 1]
        shakeAnimation.duration = 0.4
        shakeAnimation.isAdditive = true
        self.saveButton.layer.add(shakeAnimation, forKey: nil)
    }
}
