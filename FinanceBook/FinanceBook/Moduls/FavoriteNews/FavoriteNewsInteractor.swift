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
    func deleteNews(_ news: FavoriteNewsRequest)
}

final class FavoriteNewsInteractor {
    
    private let presenter: IFavoriteNewsPresenter
    private let dataManager: INewsDataManager
    private let networkManager = NewsNetworkManager()
    
    init(presenter: IFavoriteNewsPresenter,
         dataManager: INewsDataManager) {
        self.presenter = presenter
        self.dataManager = dataManager
    }
}

extension FavoriteNewsInteractor: IFavoriteNewsInteractor {
    
    func loadNews() {
        self.dataManager.getListNews { [ weak self ] result in
            switch result {
            case .success(let model):
                self?.presenter.setFavoriteNewsState(model)
            case .failure(let error):
                self?.presenter.showError(error)
            }
        }
    }
    
    func deleteNews(_ news: FavoriteNewsRequest) {
        self.dataManager.delete(news: news) { [ weak self ] result in
            switch result {
            case .success():
                self?.loadNews()
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
