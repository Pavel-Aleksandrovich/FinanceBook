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
    func loadNews(language: String?, category: String?)
    func loadImageDataFrom(url: String?, complition: @escaping(UIImage?) -> ())
}

final class ListNewsInteractor {
    
    private var category: String? = Category.general.rawValue {
        didSet {
            self.presenter.clearData()
        }
    }
    
    private var language: String? = "us" {
        didSet {
            self.languageDidUpdate()
        }
    }
    
    private let presenter: IListNewsPresenter
    private let networkManager = NetworkManager()
    
    init(presenter: IListNewsPresenter) {
        self.presenter = presenter
    }
}

extension ListNewsInteractor: IListNewsInteractor {
    
    func loadImageDataFrom(url: String?,
                           complition: @escaping(UIImage?) -> ()) {
        guard let url = url else { return }
        
        self.networkManager.loadImageDataFrom(url: url) { [ weak self ] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    complition(data)
                }
            case .failure(let error):
                self?.presenter.showError(error)
            }
        }
    }
    
    func loadNews(language: String? = nil, category: String? = nil) {
        
        if category != nil {
            self.category = category
        }
        let category = self.category ?? Category.general.rawValue
        
        if language != nil {
            self.language = language
        }
        let language = self.language ?? "us"
        
        self.networkManager.loadNews(language: language,
                                     category: category,
                                     page: 1) { [ weak self ] result in
            switch result {
            case .success(let news):
                self?.presenter.setNews(news)
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

private extension ListNewsInteractor {
    
    func languageDidUpdate() {
        self.presenter.clearData()
        
        guard let title = self.language else { return }
        self.presenter.setLanguageBarButtonTitle(title: title)
    }
}
