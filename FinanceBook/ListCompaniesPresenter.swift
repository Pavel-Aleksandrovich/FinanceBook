//
//  ListCompaniesPresenter.swift
//  Homework-10
//
//  Created by pavel mishanin on 08.06.2022.
//

import Foundation

protocol IListCompaniesPresenter: AnyObject {
    func onViewAttached(controller: IListCompaniesViewController,
                        view: IListCompaniesView,
                        tableAdapter: IListCompaniesTableAdapter)
//    func setCompanies(_ company: [CompanyDTO])
//    func addCompany(_ company: CompanyDTO)
    func deleteCompanyAt(_ id: UUID)
    func showError(_ error: Error)
    func setNews(_ news: News)
}

final class ListCompaniesPresenter {
    
    private weak var view: IListCompaniesView?
    private weak var controller: IListCompaniesViewController?
    private weak var tableAdapter: IListCompaniesTableAdapter?
}

extension ListCompaniesPresenter: IListCompaniesPresenter {
    
    func onViewAttached(controller: IListCompaniesViewController,
                        view: IListCompaniesView,
                        tableAdapter: IListCompaniesTableAdapter) {
        self.controller = controller
        self.view = view
        self.tableAdapter = tableAdapter
        self.tableAdapter?.tableView = self.view?.getTableView()
    }
    
//    func setCompanies(_ company: [CompanyDTO]) {
//        DispatchQueue.main.async {
//            let companyViewModel = company.map { CompanyViewModel(company: $0)}
//            self.tableAdapter?.setCompanies(companyViewModel)
//        }
//    }
//    
//    func addCompany(_ company: CompanyDTO) {
//        DispatchQueue.main.async {
//            let companyViewModel = CompanyViewModel(company: company)
//            self.tableAdapter?.addCompany(companyViewModel)
//        }
//    }
    
    func deleteCompanyAt(_ id: UUID) {
        DispatchQueue.main.async {
//            self.tableAdapter?.deleteCompanyAt(id)
        }
    }
    
    func showError(_ error: Error) {
        DispatchQueue.main.async {
            self.controller?.showError(error.localizedDescription)
        }
    }
    
    func setNews(_ news: News) {
        DispatchQueue.main.async {
            self.tableAdapter?.setNews(news)
        }
    }
}
