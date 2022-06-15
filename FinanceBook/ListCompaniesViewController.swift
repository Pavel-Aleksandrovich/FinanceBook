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
    private let router: IListNewsRouter

    init(interactor: IListCompaniesInteractor,
         router: IListNewsRouter,
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
        self.setScrollDidEndHandler()
        self.tableAdapter.delegate = self
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

extension ListCompaniesViewController: ListCompaniesTableAdapterDelegate {
    
    func loadImageData(url: String?, complition: @escaping (Data) -> ()) {
        self.interactor.loadImageDataFrom(url: url, complition: complition)
    }
}

private extension ListCompaniesViewController {
    
    func setScrollDidEndHandler() {
        
        self.tableAdapter.scrollDidEndHandler = {
            self.interactor.loadNews()
        }
    }
    
    func setOnCellTappedHandler() {
        self.tableAdapter.onCellTappedHandler = { [ weak self ] article in
//            self?.router.showListEmployeesModule(company)
        }
    }
    
    func setOnCellDeleteHandler() {
//        self.tableAdapter.onCellDeleteHandler = { [ weak self ] company in
//            self?.interactor.deleteCompany(company)
//        }
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
