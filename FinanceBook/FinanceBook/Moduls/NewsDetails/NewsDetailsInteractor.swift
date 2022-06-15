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
    func loadImageDataFrom(url: String?)
}

final class NewsDetailsInteractor {
    
    private var page = 1
    private let presenter: INewsDetailsPresenter
    private let networkManager = NetworkManager()
    
    init(presenter: INewsDetailsPresenter, article: Article) {
        self.presenter = presenter
        self.setData(article: article)
    }
}

extension NewsDetailsInteractor: INewsDetailsInteractor {
    
    func loadImageDataFrom(url: String?) {
        guard let url = url else { return }
        self.networkManager.loadImageDataFrom(url: url) { [ weak self ] result in
            switch result {
            case .success(let data):
                self?.presenter.setImageDate(data)
            case .failure(let error):
                print(error)
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
    
    func setData(article: Article) {
        self.loadImageDataFrom(url: article.urlToImage)
        self.presenter.setNews(article)
    }
}
