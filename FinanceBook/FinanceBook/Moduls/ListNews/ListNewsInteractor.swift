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
    
    private var page = 1
    private let presenter: IListNewsPresenter
    private let networkManager = NetworkManager()
    
    init(presenter: IListNewsPresenter) {
        self.presenter = presenter
    }
}

extension ListNewsInteractor: IListNewsInteractor {
    
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
        self.networkManager.loadNews(page: 1) { [ weak self ] result in
            switch result {
            case .success(let news):
                print(50)
                self?.presenter.setNews(news)
            case .failure(let error):
                print(52)
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
