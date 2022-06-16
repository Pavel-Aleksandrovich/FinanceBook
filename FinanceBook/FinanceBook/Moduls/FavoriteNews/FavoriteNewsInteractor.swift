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
    func loadImageDataFrom(url: String?, complition: @escaping(Data) -> ())
}

final class FavoriteNewsInteractor {
    
    private var page = 0
    private let presenter: IFavoriteNewsPresenter
    private let networkManager = NetworkManager()
    
    init(presenter: IFavoriteNewsPresenter) {
        self.presenter = presenter
    }
}

extension FavoriteNewsInteractor: IFavoriteNewsInteractor {
    
    func loadImageDataFrom(url: String?, complition: @escaping(Data) -> ()) {
        guard let url = url else { return }
        self.networkManager.loadImageDataFrom(url: url) { [ weak self ] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    complition(data)
                }
            case .failure(let error):
                self?.presenter.showError(error)
            }
        }
    }
    
    func loadNews() {
        self.page += 1
        self.networkManager.loadNews(page: self.page) { [ weak self ] result in
            switch result {
            case .success(let news):
                self?.presenter.setNews(news)
            case .failure(let error):
                print(error.localizedDescription)
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
