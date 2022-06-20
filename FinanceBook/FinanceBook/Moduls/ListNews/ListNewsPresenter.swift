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
    func setNews(_ news: News)
    func clearData()
    func setLanguageBarButtonTitle(title: String)
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
        self.mainQueue.async {
            self.controller?.showError(error.localizedDescription)
        }
    }
    
    func setNews(_ news: News) {
        self.mainQueue.async {
            self.tableAdapter?.setNews(news)
        }
    }
    
    func clearData() {
        self.mainQueue.async {
            self.tableAdapter?.clearData()
        }
    }
    
    func setLanguageBarButtonTitle(title: String) {
        
        self.mainQueue.async {
            self.controller?.setLanguageBarButtonTitle(title: title)
        }
    }
}
