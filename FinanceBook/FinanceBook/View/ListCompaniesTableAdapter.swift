//
//  ListCompaniesTableAdapter.swift
//  Homework-10
//
//  Created by pavel mishanin on 08.06.2022.
//

import UIKit

protocol IListCompaniesTableAdapter: AnyObject {
    var tableView: UITableView? { get set }
    var onCellDeleteHandler: ((CompanyRequest) -> ())? { get set }
    var onCellTappedHandler: ((CompanyRequest) -> ())? { get set }
    func setCompanies(_ company: [CompanyViewModel])
    func addCompany(_ company: CompanyViewModel)
    func deleteCompanyAt(_ id: UUID)
    func setNews(_ news: News)
}

final class ListCompaniesTableAdapter: NSObject {
    
    private var companyArray: [CompanyViewModel] = []
    private var articleArray: [Article] = []
    var onCellDeleteHandler: ((CompanyRequest) -> ())?
    var onCellTappedHandler: ((CompanyRequest) -> ())?
    weak var tableView: UITableView? {
        didSet {
            self.tableView?.delegate = self
            self.tableView?.dataSource = self
            self.tableView?.register(ListCompaniesCell.self,
                                     forCellReuseIdentifier: ListCompaniesCell.id)
        }
    }
}

extension ListCompaniesTableAdapter: IListCompaniesTableAdapter {
    
    func setCompanies(_ company: [CompanyViewModel]) {
        self.companyArray = company
        self.tableView?.reloadData()
    }
    
    func addCompany(_ company: CompanyViewModel) {
        self.companyArray.append(company)
        self.tableView?.reloadData()
    }
    
    func deleteCompanyAt(_ id: UUID) {
        let index = self.companyArray.firstIndex { $0.id == id }
        if let index = index {
            self.companyArray.remove(at: index)
            let indexPath = IndexPath(row: index, section: 0)
            self.tableView?.deleteRows(at: [indexPath], with: .fade)
            self.tableView?.reloadData()
        }
    }
    
    func setNews(_ news: News) {
        self.articleArray = news.articles
        self.tableView?.reloadData()
    }
}

extension ListCompaniesTableAdapter: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        articleArray.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCompaniesCell.id,
                                                       for: indexPath) as? ListCompaniesCell else { return UITableViewCell() }
        
        let article = articleArray[indexPath.row]
        cell.update(article: article)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let companyRequest = CompanyRequest(company: companyArray[indexPath.row])
        self.onCellTappedHandler?(companyRequest)
    }
}
