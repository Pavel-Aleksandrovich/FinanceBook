//
//  ListNewsInteractor.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

protocol IListNewsInteractor: AnyObject {
    func onViewAttached(controller: IListNewsViewController,
                        view: IListNewsView,
                        tableAdapter: IListNewsTableAdapter)
    func loadNews(country: Country?, category: String?)
    func loadImageFrom(url: String, complition: @escaping(UIImage) -> ())
}

final class ListNewsInteractor {
    
    private var category: String = Category.general.rawValue
    private var country: Country = .us
    
    private let presenter: IListNewsPresenter
    private let networkManager: INewsNetworkManager
    
    init(presenter: IListNewsPresenter,
         networkManager: INewsNetworkManager) {
        self.presenter = presenter
        self.networkManager = networkManager
    }
}

extension ListNewsInteractor: IListNewsInteractor {
    
    func loadImageFrom(url: String,
                       complition: @escaping(UIImage) -> ()) {
        self.networkManager.loadImageFrom(url: url) { [ weak self ] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    complition(image)
                }
            case .failure(let error):
                self?.presenter.showError(error)
            }
        }
    }
    
    func loadNews(country: Country? = nil, category: String? = nil) {
        
        if let category = category {
            self.category = category
        }
        
        if let country = country {
            self.country = country
            self.presenter.setCountryBarButtonTitle(title: country.name)
        }
        
        self.networkManager.loadNews(country: self.country.rawValue,
                                     category: self.category) { [ weak self ] result in
            switch result {
            case .success(let news):
                self?.presenter.setNewsSuccessState(news)
            case .failure(let error):
                self?.presenter.showError(error)
            }
        }
    }
    
    func onViewAttached(controller: IListNewsViewController,
                        view: IListNewsView,
                        tableAdapter: IListNewsTableAdapter) {
        self.presenter.onViewAttached(controller: controller,
                                      view: view,
                                      tableAdapter: tableAdapter)
    }
}
