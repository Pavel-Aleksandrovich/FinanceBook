//
//  FavoriteNewsViewController.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit

protocol IFavoriteNewsViewController: AnyObject {
    func showError(_ error: String)
}

final class FavoriteNewsViewController: UIViewController {
    
    private let mainView = FavoriteNewsView()
    private let tableAdapter: IFavoriteNewsTableAdapter
    private let interactor: IFavoriteNewsInteractor
    private let router: IFavoriteNewsRouter

    init(interactor: IFavoriteNewsInteractor,
         router: IFavoriteNewsRouter,
         tableAdapter: IFavoriteNewsTableAdapter) {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.interactor.loadNews()
    }
}

extension FavoriteNewsViewController: IFavoriteNewsViewController {
    
    func showError(_ error: String) {
        self.router.showErrorAlert(error)
    }
}

private extension FavoriteNewsViewController {
    
    func setOnCellTappedHandler() {
        self.tableAdapter.onCellTappedHandler = { [ weak self ] article in
            self?.router.showArticleDetails(article)
        }
    }
    
    func setOnCellDeleteHandler() {
        self.tableAdapter.onCellDeleteHandler = { news in
            self.interactor.deleteNews(news)
        }
    }
}
