//
//  ViewController.swift
//  Homework-10
//
//  Created by pavel mishanin on 08.06.2022.
//

import UIKit

protocol IListCompaniesViewController: AnyObject {
    func showError(_ error: String)
}

final class ListCompaniesViewController: UIViewController {
    
    private enum Constants {
        static let barButtonTitle = "Add Company"
    }
    
    private let mainView = ListCompaniesView()
    private let tableAdapter: IListCompaniesTableAdapter
    private let interactor: IListCompaniesInteractor
    private let router: IListCompaniesRouter
    
    init(interactor: IListCompaniesInteractor,
         router: IListCompaniesRouter,
         tableAdapter: IListCompaniesTableAdapter) {
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
        self.setOnCellTappedHandler()
        self.setOnCellDeleteHandler()
        self.setRightBarButton()
        self.interactor.loadNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.interactor.fetchData()
    }
}

extension ListCompaniesViewController: IListCompaniesViewController {
    
    func showError(_ error: String) {
        self.router.showErrorAlert(error)
    }
}

private extension ListCompaniesViewController {
    
    func setOnCellTappedHandler() {
        self.tableAdapter.onCellTappedHandler = { [ weak self ] company in
            self?.router.showListEmployeesModule(company)
        }
    }
    
    func setOnCellDeleteHandler() {
        self.tableAdapter.onCellDeleteHandler = { [ weak self ] company in
            self?.interactor.deleteCompany(company)
        }
    }
    
    func setRightBarButton() {
        let rightButton = UIBarButtonItem(title: Constants.barButtonTitle,
                                          style: .plain,
                                          target: self,
                                          action: #selector(addCompanyButtonTapped))
        self.navigationItem.setRightBarButton(rightButton, animated: false)
    }
    
    @objc func addCompanyButtonTapped() {
        self.router.showAlert { company in
            self.interactor.createCompany(company)
        }
    }
}
