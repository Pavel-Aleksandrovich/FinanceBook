//
//  ChartViewController.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit

protocol IHistoryViewController: AnyObject {
    func showError(_ error: String)
}

final class HistoryViewController: UIViewController {
    
    private let mainView = HistoryView()
    private let tableAdapter: IHistoryTableAdapter
    private let interactor: IHistoryInteractor
    private let router: IHistoryRouter

    init(interactor: IHistoryInteractor,
         router: IHistoryRouter,
         tableAdapter: IHistoryTableAdapter) {
        self.interactor = interactor
        self.router = router
        self.tableAdapter = tableAdapter
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
                                       view: self.mainView,
                                       tableAdapter: self.tableAdapter)
        self.createAddTransactionBarButton()
        self.setOnCellDeleteHandler()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.interactor.loadData()
    }
}

extension HistoryViewController: IHistoryViewController {
    func showError(_ error: String) {
        self.router.showAlert(error)
    }
}

private extension HistoryViewController {
    
    func setOnCellDeleteHandler() {
        self.tableAdapter.onCellDeleteHandler = { [ weak self ] viewModel in
            self?.interactor.deleteTransaction(viewModel)
        }
    }
    
    func createAddTransactionBarButton() {
        let item = UIBarButtonItem(barButtonSystemItem: .add,
                                   target: self,
                                   action: #selector
                                   (self.addTransactionButtonTapped))
        item.tintColor = MainAttributs.color
        self.navigationItem.rightBarButtonItem = item
    }
    
    @objc func addTransactionButtonTapped() {
        self.router.showAddTransactionModul()
    }
}
