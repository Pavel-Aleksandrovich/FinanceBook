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
        self.configView()
    }
}

extension NewsDetailsViewController: INewsDetailsViewController {
    
    func showError(_ error: String) {
        self.router.showErrorAlert(error)
    }
    
    func showSuccess() {
        self.router.showErrorAlert("News was added to favorite")
    }
}

private extension NewsDetailsViewController {
    
    func configView() {
        self.createExitBarButton()
        self.createFavoriteBarButton()
    }
    
    func createExitBarButton() {
        let image = UIImage(systemName: "xmark.circle")
        let item = UIBarButtonItem(image: image,
                                   style: .plain,
                                   target: self,
                                   action: #selector
                                   (self.exitButtonTapped))
        navigationItem.rightBarButtonItem = item
    }
    
    @objc func exitButtonTapped() {
        self.router.dismiss()
    }
    
    func createFavoriteBarButton() {
        let image = UIImage(systemName: "heart")
        let item = UIBarButtonItem(image: image,
                                   style: .plain,
                                   target: self,
                                   action: #selector
                                   (self.favoriteButtonTapped))
        navigationItem.leftBarButtonItem = item
    }
    
    @objc func favoriteButtonTapped() {
        let model = self.mainView.getModel()
        self.interactor.addToFavorite(news: model)
    }
}
