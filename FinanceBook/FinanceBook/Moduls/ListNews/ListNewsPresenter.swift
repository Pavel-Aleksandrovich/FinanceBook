//
//  ListNewsPresenter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import Foundation

protocol IListNewsPresenter: AnyObject {
    func onViewAttached(controller: IListNewsViewController,
                        view: IListNewsView,
                        tableAdapter: IListNewsTableAdapter)
    func showError(_ error: Error)
    func setData(_ news: NewsResponse)
    func setCountryBarButtonTitle(title: String)
    func setState(_ state: ListNewsState)
}

final class ListNewsPresenter {
    
    private weak var view: IListNewsView?
    private weak var controller: IListNewsViewController?
    private weak var tableAdapter: IListNewsTableAdapter?
    
    private let mainQueue = DispatchQueue.main
}

extension ListNewsPresenter: IListNewsPresenter {
    
    func onViewAttached(controller: IListNewsViewController,
                        view: IListNewsView,
                        tableAdapter: IListNewsTableAdapter) {
        self.controller = controller
        self.view = view
        self.tableAdapter = tableAdapter
        self.tableAdapter?.tableView = self.view?.getTableView()
    }
    
    func showError(_ error: Error) {
        if let error = error as? NewsNetworkError {
            self.mainQueue.async {
                self.controller?.showError(error.rawValue)
            }
        } else {
            self.mainQueue.async {
                self.controller?.showError(error.localizedDescription)
            }
        }
    }
    
    func setState(_ state: ListNewsState) {
        self.mainQueue.async {
            self.tableAdapter?.setState(state)
        }
    }
    
    func setData(_ news: NewsResponse) {
        let viewModel = news.articles.compactMap { NewsViewModel(from: $0) }
        self.mainQueue.async {
            self.tableAdapter?.setData(viewModel)
        }
    }
    
    func setCountryBarButtonTitle(title: String) {
        self.mainQueue.async {
            self.controller?.setCountryBarButtonTitle(title: title)
        }
    }
}
