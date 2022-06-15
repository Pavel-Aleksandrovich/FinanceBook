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
    func deleteCompanyAt(_ id: UUID)
    func showError(_ error: Error)
    func setNews(_ news: News)
}

final class ListNewsPresenter {
    
    private weak var view: IListNewsView?
    private weak var controller: IListNewsViewController?
    private weak var tableAdapter: IListNewsTableAdapter?
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
