//
//  FavoriteNewsInteractor.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import Foundation

protocol IFavoriteNewsInteractor: AnyObject {
    func onViewAttached(controller: IFavoriteNewsViewController,
                        view: IFavoriteNewsView,
                        tableAdapter: IFavoriteNewsTableAdapter)
    func loadNews()
    func deleteNews(_ news: NewsResponse)
}

final class FavoriteNewsInteractor {
    
    private let presenter: IFavoriteNewsPresenter
    private let dataManager: IDataManager
    private let networkManager = NetworkManager()
    
    init(presenter: IFavoriteNewsPresenter, dataManager: IDataManager) {
        self.presenter = presenter
        self.dataManager = dataManager
    }
}

extension FavoriteNewsInteractor: IFavoriteNewsInteractor {
    
    func loadNews() {
        self.dataManager.getListNews { [ weak self ] result in
            switch result {
            case .success(let model):
                self?.presenter.setFavoriteNews(model)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func deleteNews(_ news: NewsResponse) {
        self.dataManager.delete(news: news) { [ weak self ] result in
            switch result {
            case .success():
                self?.presenter.deleteNewsAt(news.id)
            case .failure(let error):
                self?.presenter.showError(error)
            }
        }
    }
    
    func onViewAttached(controller: IFavoriteNewsViewController,
                        view: IFavoriteNewsView,
                        tableAdapter: IFavoriteNewsTableAdapter) {
        self.presenter.onViewAttached(controller: controller,
                                      view: view,
                                      tableAdapter: tableAdapter)
    }
}
