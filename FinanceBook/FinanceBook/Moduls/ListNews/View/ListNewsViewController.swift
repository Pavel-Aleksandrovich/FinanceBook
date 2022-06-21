//
//  ListNewsViewController.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

protocol IListNewsViewController: AnyObject {
    func showError(_ error: String)
    func setCountryBarButtonTitle(title: String)
}

final class ListNewsViewController: UIViewController {
    
    private enum Constants {
        static let barButtonTitle = "Add Company"
    }
    
    private let cell = ListNewsCell()
    private let mainView = ListNewsView()
    private let tableAdapter: IListNewsTableAdapter
    private let interactor: IListNewsInteractor
    private let router: IListNewsRouter
    
    private var collectionAdapter: ICollectionViewAdapter
    private var countryBarButton = UIBarButtonItem()

    init(interactor: IListNewsInteractor,
         router: IListNewsRouter,
         tableAdapter: IListNewsTableAdapter,
         collectionAdapter: ICollectionViewAdapter) {
        self.interactor = interactor
        self.router = router
        self.tableAdapter = tableAdapter
        self.collectionAdapter = collectionAdapter
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
        self.collectionAdapter.collectionView = self.mainView.getCollectionView()
        self.setOnCellTappedHandler()
        self.interactor.loadNews(country: nil, category: nil)
        self.setOnCellCollectionTappedHandler()
        self.createCountryBarButton()
        self.tableAdapter.delegate = self
    }
}

extension ListNewsViewController: IListNewsViewController {
    
    func showError(_ error: String) {
        self.router.showErrorAlert(error)
    }
    
    func setCountryBarButtonTitle(title: String) {
        self.countryBarButton.title = title
    }
}

extension ListNewsViewController: ListNewsTableAdapterDelegate {
    
    func loadImageData(url: String?, completion: @escaping (UIImage?) -> ()) {
        self.interactor.loadImageDataFrom(url: url, complition: completion)
    }
}

private extension ListNewsViewController {
    
    func createCountryBarButton() {
        self.countryBarButton = UIBarButtonItem(title: "US",
                                                 style: .done,
                                                 target: self,
                                                 action:#selector
                                                 (self.countryButtonTapped))
        
        self.navigationItem.rightBarButtonItem = self.countryBarButton
    }
    
    @objc func countryButtonTapped() {
        self.router.showCountryAlert { [ weak self ] country in
            self?.interactor.loadNews(country: country, category: nil)
        }
    }
    
    func setOnCellTappedHandler() {
        self.tableAdapter.onCellTappedHandler = { [ weak self ] article in
            self?.router.showArticleDetails(article)
        }
    }
    
    func setOnCellCollectionTappedHandler() {
        self.collectionAdapter.onCellTappedHandler = { [ weak self ] category in
            self?.interactor.loadNews(country: nil, category: category)
        }
    }
}
