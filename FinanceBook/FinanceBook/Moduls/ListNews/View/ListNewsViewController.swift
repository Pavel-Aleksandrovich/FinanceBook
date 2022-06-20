//
//  ListNewsViewController.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

protocol IListNewsViewController: AnyObject {
    func showError(_ error: String)
    func setLanguageBarButtonTitle(title: String)
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
    private var languageBarButton = UIBarButtonItem()

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
        self.collectionAdapter.collectionView = self.mainView.getCollectionView()
        self.interactor.onViewAttached(controller: self,
                                       view: self.mainView,
                                       tableAdapter: self.tableAdapter)
        self.setOnCellTappedHandler()
        self.interactor.loadNews(language: nil, category: nil)
        self.setScrollDidEndHandler()
        self.tableAdapter.delegate = self
        self.setOnCellCollectionTappedHandler()
        self.createLanguageBarButton()
        self.createLanguageBarButton()
    }
}

extension ListNewsViewController: IListNewsViewController {
    
    func showError(_ error: String) {
        self.router.showErrorAlert(error)
    }
    
    func setLanguageBarButtonTitle(title: String) {
        self.languageBarButton.title = title
    }
}

extension ListNewsViewController: ListNewsTableAdapterDelegate {
    
    func loadImageData(url: String?, complition: @escaping (Data) -> ()) {
        self.interactor.loadImageDataFrom(url: url, complition: complition)
    }
}

private extension ListNewsViewController {
    
    func createLanguageBarButton() {
        self.languageBarButton = UIBarButtonItem(title: "US",
                                                 style: .done,
                                                 target: self,
                                                 action:#selector
                                                 (self.languageButtonTapped))
        
        self.navigationItem.rightBarButtonItem = self.languageBarButton
    }
    
    @objc func languageButtonTapped() {
        self.router.showLanguageAlert { [ weak self ] language in
            self?.interactor.loadNews(language: language, category: nil)
        }
    }
    
    func setScrollDidEndHandler() {
        self.tableAdapter.scrollDidEndHandler = {
            self.interactor.loadNews(language: nil, category: nil)
        }
    }
    
    func setOnCellTappedHandler() {
        self.tableAdapter.onCellTappedHandler = { [ weak self ] article in
            self?.router.showArticleDetails(article)
        }
    }
    
    func setOnCellCollectionTappedHandler() {
        self.collectionAdapter.onCellTappedHandler = { [ weak self ] category in
            self?.interactor.loadNews(language: nil, category: category)
        }
    }
}
