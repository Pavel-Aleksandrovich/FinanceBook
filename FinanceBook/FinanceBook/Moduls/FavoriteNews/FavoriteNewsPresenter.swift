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
    func setFavoriteNewsState(_ news: [FavoriteNewsResponse])
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
    
    func setFavoriteNewsState(_ news: [FavoriteNewsResponse]) {
        if news.isEmpty {
            self.mainQueue.async {
            self.tableAdapter?.setFavoriteNewsState(.empty)
            }
        } else {
            let viewModel = news.map { FavoriteNewsViewModel(viewModel: $0) }
            
            self.mainQueue.async {
                self.tableAdapter?.setFavoriteNewsState(.success(viewModel))
            }
        }
    }
    
    func showError(_ error: Error) {
        self.mainQueue.async {
            self.controller?.showError(error.localizedDescription)
        }
    }
}
