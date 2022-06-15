//
//  ListNewsViewController.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

protocol IListNewsViewController: AnyObject {
    func showError(_ error: String)
}

final class ListNewsViewController: UIViewController {
    
    private enum Constants {
        static let barButtonTitle = "Add Company"
    }
    
    private let mainView = ListNewsView()
    private let tableAdapter: IListNewsTableAdapter
    private let interactor: IListNewsInteractor
    private let router: IListNewsRouter

    init(interactor: IListNewsInteractor,
         router: IListNewsRouter,
         tableAdapter: IListNewsTableAdapter) {
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
        self.setRightBarButton()
        self.interactor.loadNews()
        self.setScrollDidEndHandler()
        self.tableAdapter.delegate = self
    }
}

extension ListNewsViewController: IListNewsViewController {
    
    func showError(_ error: String) {
        self.router.showErrorAlert(error)
    }
}

extension ListNewsViewController: ListNewsTableAdapterDelegate {
    
    func loadImageData(url: String?, complition: @escaping (Data) -> ()) {
        self.interactor.loadImageDataFrom(url: url, complition: complition)
    }
}

private extension ListNewsViewController {
    
    func setScrollDidEndHandler() {
        
        self.tableAdapter.scrollDidEndHandler = {
            self.interactor.loadNews()
        }
    }
    
    func setOnCellTappedHandler() {
        self.tableAdapter.onCellTappedHandler = { [ weak self ] article in
            self?.router.showArticleDetails(article)
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
        self.router.showAlert { 
//            self.interactor.createCompany(company)
        }
    }
}
