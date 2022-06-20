//
//  FavoriteNewsPresenter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import Foundation

protocol IFavoriteNewsPresenter: AnyObject {
    func onViewAttached(controller: IFavoriteNewsViewController,
                        view: IFavoriteNewsView,
                        tableAdapter: IFavoriteNewsTableAdapter)
    func showError(_ error: Error)
    func setFavoriteNews(_ news: [NewsResponse])
    func deleteNewsAt(_ id: UUID)
}

final class FavoriteNewsPresenter {
    
    private weak var view: IFavoriteNewsView?
    private weak var controller: IFavoriteNewsViewController?
    private weak var tableAdapter: IFavoriteNewsTableAdapter?
    
    private let mainQueue = DispatchQueue.main
}

extension FavoriteNewsPresenter: IFavoriteNewsPresenter {
    
    func onViewAttached(controller: IFavoriteNewsViewController,
                        view: IFavoriteNewsView,
                        tableAdapter: IFavoriteNewsTableAdapter) {
        self.controller = controller
        self.view = view
        self.tableAdapter = tableAdapter
        self.tableAdapter?.tableView = self.view?.getTableView()
    }
    
    func setFavoriteNews(_ news: [NewsResponse]) {
        self.mainQueue.async {
            self.tableAdapter?.setFavoriteNews(news)
        }
    }
    
    func showError(_ error: Error) {
        self.mainQueue.async {
            self.controller?.showError(error.localizedDescription)
        }
    }
    
    func deleteNewsAt(_ id: UUID) {
        self.mainQueue.async {
            self.tableAdapter?.deleteNewsAt(id)
        }
    }
}
