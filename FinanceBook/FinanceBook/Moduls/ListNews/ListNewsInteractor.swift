//
//  ListNewsInteractor.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import Foundation

protocol IListNewsInteractor: AnyObject {
    func onViewAttached(controller: IListNewsViewController,
                        view: IListNewsView,
                        tableAdapter: IListNewsTableAdapter)
    func loadNews()
    func loadImageDataFrom(url: String?, complition: @escaping(Data) -> ())
}

final class ListNewsInteractor {
    
    private var page = 0
    private let presenter: IListNewsPresenter
    private let networkManager = NetworkManager()
    
    init(presenter: IListNewsPresenter) {
        self.presenter = presenter
    }
}

extension ListNewsInteractor: IListNewsInteractor {
    
    func loadImageDataFrom(url: String?, complition: @escaping(Data) -> ()) {
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
    
    func loadNews() {
        self.page += 1
        self.networkManager.loadNews(page: self.page) { [ weak self ] result in
            switch result {
            case .success(let news):
                self?.presenter.setNews(news)
            case .failure(let error):
                print(error.localizedDescription)
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
