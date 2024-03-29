//
//  NewSegmentViewController.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

protocol ITransactionDetailsViewController: AnyObject {
    func showError(_ error: String)
    func showSuccess()
}

final class TransactionDetailsViewController: UIViewController {
    
    private let mainView = TransactionDetailsView()
    private let interactor: ITransactionDetailsInteractor
    private let router: ITransactionDetailsRouter
    
    init(interactor: ITransactionDetailsInteractor,
         router: ITransactionDetailsRouter) {
        self.interactor = interactor
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = self.mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor.onViewAttached(controller: self,
                                       view: self.mainView)
        self.router.setupViewController(self)
        self.setHandlers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
}

extension TransactionDetailsViewController: ITransactionDetailsViewController {
    
    func showError(_ error: String) {
        func showError(_ error: String) {
            self.router.showAlert(error)
        }
    }
    
    func showSuccess() {
        self.router.showSuccessAlert { [ weak self ] in
            self?.router.popToRoot()
        }
    }
}

extension TransactionDetailsViewController: ListCategoryViewControllerDelegate {
    
    func setData(_ model: CategoryType) {
        self.mainView.setCategory(model)
    }
}

private extension TransactionDetailsViewController {
    
    func setHandlers() {
        self.setCheckTextFieldsHandler()
        self.setSaveButtonTappedHandler()
        self.setOnCellTappedHandler()
    }
    
    func setCheckTextFieldsHandler() {
        self.mainView.textFieldChangeHandler = { [ weak self ] in
            let viewModel = self?.mainView.getViewModel()
            self?.interactor.checkTextFields(viewModel: viewModel)
        }
    }
    
    func setSaveButtonTappedHandler() {
        self.mainView.saveButtonTappedHandler = { [ weak self ] in
            let viewModel = self?.mainView.getViewModel()
            self?.interactor.createTransaction(viewModel)
        }
    }
    
    func setOnCellTappedHandler() {
        self.mainView.onCellTappedHandler = { type in
            self.router.showCategoryModul(delegate: self)
        }
    }
}


