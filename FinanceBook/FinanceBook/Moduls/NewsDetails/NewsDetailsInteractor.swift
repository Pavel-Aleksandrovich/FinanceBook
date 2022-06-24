//
//  NewsDetailsInteractor.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import Foundation

protocol INewsDetailsInteractor: AnyObject {
    func onViewAttached(controller: INewsDetailsViewController,
                        view: INewsDetailsView)
    func addToFavorite(news: NewsDetailsRequest?)
}

final class NewsDetailsInteractor {
    
    private let presenter: INewsDetailsPresenter
    private let dataManager: INewsDataManager
    private let networkManager: INewsNetworkManager
    
    init(presenter: INewsDetailsPresenter,
         dataManager: INewsDataManager,
         networkManager: INewsNetworkManager,
         article: NewsRequest) {
        self.presenter = presenter
        self.dataManager = dataManager
        self.networkManager = networkManager
        self.setData(article: article)
    }
}

extension NewsDetailsInteractor: INewsDetailsInteractor {
    
    func addToFavorite(news: NewsDetailsRequest?) {
        guard let news = news else { return }
        
        self.dataManager.create(news: news) { [ weak self ] result in
            switch result {
            case .success():
                self?.presenter.showSuccess()
            case .failure(let error):
                self?.presenter.showError(error)
            }
        }
    }
    
    func onViewAttached(controller: INewsDetailsViewController,
                        view: INewsDetailsView) {
        self.presenter.onViewAttached(controller: controller,
                                      view: view)
    }
}

private extension NewsDetailsInteractor {
    
    func setData(article: NewsRequest) {
        self.presenter.setNews(article)
        self.loadImageFrom(url: article.imageUrl)
    }
    
    func loadImageFrom(url: String) {
        self.networkManager.loadImageFrom(url: url) { [ weak self ] result in
            switch result {
            case .success(let image):
                self?.presenter.setImage(image)
            case .failure(let error):
                self?.presenter.showError(error)
            }
        }
    }
}
