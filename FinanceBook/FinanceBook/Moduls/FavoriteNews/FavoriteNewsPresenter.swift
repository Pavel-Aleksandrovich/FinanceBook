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
    func deleteCompanyAt(_ id: UUID)
    func showError(_ error: Error)
    func setNews(_ news: News)
}

final class FavoriteNewsPresenter {
    
    private weak var view: IFavoriteNewsView?
    private weak var controller: IFavoriteNewsViewController?
    private weak var tableAdapter: IFavoriteNewsTableAdapter?
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
    
    func deleteCompanyAt(_ id: UUID) {
        DispatchQueue.main.async {
//            self.tableAdapter?.deleteCompanyAt(id)
        }
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
//            self.controller?.showError(error.localizedDescription)
        }
    }
    
    func setNews(_ news: News) {
        DispatchQueue.main.async {
            self.tableAdapter?.setNews(news)
        }
    }
}
