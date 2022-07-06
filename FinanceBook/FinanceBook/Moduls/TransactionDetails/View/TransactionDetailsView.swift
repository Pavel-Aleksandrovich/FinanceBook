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
    func showErrorNumberTextField()
    func getCollectionView() -> UICollectionView 
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
    private let dateTextField = TransactionDetailsTextFieldView(settings:
            .init(header: Constants.dateTextFieldHeader,
                  placeholder: Constants.dateTextFieldPlaceholder))
    private let numberTextField = TransactionDetailsTextFieldView(settings:
            .init(header: Constants.numberTextFieldHeader,
                  placeholder: Constants.numberTextFieldPlaceholder))
    private let transactionPicker = TransactionDetailsPicker()
    private let keyboardObserver = KeyboardObserver()
    private let layout = UICollectionViewFlowLayout()
    private let collectionAdapter = TransactionDetailsCollectionView()
    private let profitLayout = UICollectionViewFlowLayout()
    private let profitCollectionAdapter = ProfitCollectionAdapter()
    
    private lazy var collectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: self.layout)
    
    private lazy var profitCollectionView = UICollectionView(frame: .zero,
                                                       collectionViewLayout: self.profitLayout)
    
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
        let color = self.collectionAdapter.selectedRow.color
        let amount = self.numberTextField.text
        let name = self.collectionAdapter.selectedRow.name
        
        return TransactionDetailsValidateRequest(name: name,
                                                 amount: amount,
                                                 date: date,
                                                 color: color)
    }
    
    func showErrorDateTextField() {
        self.dateTextField.showShakeAnimation()
    }
    
    func showErrorNumberTextField() {
        self.numberTextField.showShakeAnimation()
    }
    
    func getCollectionView() -> UICollectionView {
        self.collectionView
    }
}

// MARK: - Config Appearance
private extension TransactionDetailsView {
    
    func configAppearance() {
        self.configView()
        self.configSaveButton()
        self.configDatePicker()
        self.configNumberTextField()
        self.configDateTextField()
        self.configLayout()
        self.configCollectionView()
        self.configProfitLayout()
        self.configProfitCollectionView()
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
    
    func configLayout() {
        self.layout.minimumInteritemSpacing = 0
        self.layout.minimumLineSpacing = 0
        self.layout.scrollDirection = .vertical
    }
    
    func configCollectionView() {
        self.collectionView.backgroundColor = .clear
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.register(TransactionDetailsCell.self,
                                      forCellWithReuseIdentifier: TransactionDetailsCell.id)
        self.collectionView.dataSource = self.collectionAdapter
        self.collectionView.delegate = self.collectionAdapter
        self.collectionView.selectItem(at: [0, 0],
                                        animated: true,
                                        scrollPosition: [])
    }
    
    func configProfitLayout() {
        self.profitLayout.minimumInteritemSpacing = 0
        self.profitLayout.minimumLineSpacing = 0
        self.profitLayout.scrollDirection = .horizontal
    }
    
    func configProfitCollectionView() {
        self.profitCollectionView.backgroundColor = .clear
        self.profitCollectionView.showsHorizontalScrollIndicator = false
        self.profitCollectionView.register(ProfitCollectionCell.self,
                                      forCellWithReuseIdentifier: ProfitCollectionCell.id)
        self.profitCollectionView.dataSource = self.profitCollectionAdapter
        self.profitCollectionView.delegate = self.profitCollectionAdapter
        self.profitCollectionView.selectItem(at: [0, 0],
                                        animated: true,
                                        scrollPosition: [])
    }
}

// MARK: - Make Constraints
private extension TransactionDetailsView {
    
    func makeConstraints() {
        self.makeProfitCollectionViewConstraints()
        self.makeSaveButtonConstraints()
        self.makeDateTextFieldConstraints()
        self.makeNumberTextFieldConstraints()
        self.makeCollectionViewConstraints()
    }
    
    func makeProfitCollectionViewConstraints() {
        self.addSubview(self.profitCollectionView)
        self.profitCollectionView.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(50)
        }
    }
    
    func makeDateTextFieldConstraints() {
        self.addSubview(self.dateTextField)
        self.dateTextField.snp.makeConstraints { make in
            make.top.equalTo(self.profitCollectionView.snp.bottom).inset(-20)
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
    
    func makeCollectionViewConstraints() {
        self.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.numberTextField.snp.bottom).inset(-10)
            make.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(300)
        }
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
}

// MARK: - Set Handlers
private extension TransactionDetailsView {
    
    func setHandlers() {
        self.setDateTextFieldToolbarHandler()
        self.setNumberTextFieldToolbarHandler()
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
    
    func dateToolbarDoneButtonTapped() {
        self.dateTextField.text = DateConverter.toStringFrom(date: self.datePicker.date)
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
