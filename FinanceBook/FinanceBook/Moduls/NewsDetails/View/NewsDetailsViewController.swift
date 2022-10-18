//
//  NewsDetailsViewController.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

protocol INewsDetailsViewController: AnyObject {
    func showError(_ error: String)
    func showSuccess()
}

final class NewsDetailsViewController: UIViewController {
    
    private enum Constants {
        static let savedSuccess = "News was added to favorite"
    }
    
    private let mainView = NewsDetailsView()
    private let interactor: INewsDetailsInteractor
    private let router: INewsDetailsRouter
    
    init(interactor: INewsDetailsInteractor,
         router: INewsDetailsRouter) {
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
        self.setOnFavoriteButtonTappedHandler()
    }
}

extension NewsDetailsViewController: INewsDetailsViewController {
    
    func showError(_ error: String) {
        self.router.showAlert(error)
    }
    
    func showSuccess() {
        self.router.showAlert(Constants.savedSuccess)
    }
}

private extension NewsDetailsViewController {
    
    func setOnFavoriteButtonTappedHandler() {
        self.mainView.onFavoriteButtonTappedHandler = { [ weak self ] in
            let model = self?.mainView.getModel()
            self?.interactor.addToFavorite(news: model)
        }
    }
}
