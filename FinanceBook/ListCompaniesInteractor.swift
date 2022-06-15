//
//  ListCompaniesInteractor.swift
//  Homework-10
//
//  Created by pavel mishanin on 08.06.2022.
//

import Foundation

protocol IListCompaniesInteractor: AnyObject {
    func fetchData()
    func createCompany(_ company: CompanyRequest)
    func deleteCompany(_ company: CompanyRequest)
    func onViewAttached(controller: IListCompaniesViewController,
                        view: IListCompaniesView,
                        tableAdapter: IListCompaniesTableAdapter)
    func loadNews()
    func loadImageDataFrom(url: String?, complition: @escaping(Data) -> ())
}

final class ListCompaniesInteractor {
    
    private var page = 1
    private let presenter: IListCompaniesPresenter
    private let networkManager = NetworkManager()
//    private let dataManager: ICompanyDataManager
    
    init(presenter: IListCompaniesPresenter) {
        self.presenter = presenter
//        self.dataManager = dataManager
    }
}

extension ListCompaniesInteractor: IListCompaniesInteractor {
    
    func loadImageDataFrom(url: String?, complition: @escaping(Data) -> ()) {
        guard let url = url else { return }
        self.networkManager.loadImageDataFrom(url: url) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    complition(data)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadNews() {
        self.page += 1
        self.networkManager.loadNews(page: 13) { [ weak self ] result in
            switch result {
            case .success(let news):
                self?.presenter.setNews(news)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchData() {
//        self.dataManager.getCompanies { [ weak self ] result in
//            switch result {
//            case .success(let companies):
//                var sortedCompanies = companies
//                sortedCompanies.sort { $0.employeeCount > $1.employeeCount}
//                self?.presenter.setCompanies(sortedCompanies)
//            case .failure(let error):
//                self?.presenter.showError(error)
//            }
//        }
    }
    
    func createCompany(_ company: CompanyRequest) {
//        let companyDto = CompanyDTO(company: company)
//        self.dataManager.add(company: companyDto) { [ weak self ] result in
//            switch result {
//            case .success():
//                self?.presenter.addCompany(companyDto)
//            case .failure(let error):
//                self?.presenter.showError(error)
//            }
//        }
    }
    
    func deleteCompany(_ company: CompanyRequest) {
//        let companyDto = CompanyDTO(company: company)
//        self.dataManager.delete(company: companyDto) { [ weak self ] result in
//            switch result {
//            case .success():
//                self?.presenter.deleteCompanyAt(companyDto.id)
//            case .failure(let error):
//                self?.presenter.showError(error)
//            }
//        }
    }
    
    func onViewAttached(controller: IListCompaniesViewController,
                        view: IListCompaniesView,
                        tableAdapter: IListCompaniesTableAdapter) {
        self.presenter.onViewAttached(controller: controller,
                                      view: view,
                                      tableAdapter: tableAdapter)
    }
}
