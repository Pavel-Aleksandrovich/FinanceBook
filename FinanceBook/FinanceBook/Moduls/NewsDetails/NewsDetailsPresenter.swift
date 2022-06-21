//
//  NewsDetailsPresenter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

protocol INewsDetailsPresenter: AnyObject {
    func onViewAttached(controller: INewsDetailsViewController,
                        view: INewsDetailsView)
    func showError(_ error: Error)
    func showSuccess()
    func setNews(_ article: NewsRequest)
    func setImageDate(_ data: UIImage?)
}

final class NewsDetailsPresenter {
    
    private weak var view: INewsDetailsView?
    private weak var controller: INewsDetailsViewController?
    
    private let mainQueue = DispatchQueue.main
}

extension NewsDetailsPresenter: INewsDetailsPresenter {
    
    func onViewAttached(controller: INewsDetailsViewController,
                        view: INewsDetailsView) {
        self.controller = controller
        self.view = view
    }
    
    func showError(_ error: Error) {
        self.mainQueue.async {
            self.controller?.showError(error.localizedDescription)
        }
    }
    
    func showSuccess() {
        self.mainQueue.async {
            self.controller?.showSuccess()
        }
    }
    
    func setNews(_ article: NewsRequest) {
        self.mainQueue.async {
            self.view?.update(article: article)
        }
    }
    
    func setImageDate(_ data: UIImage?) {
        self.mainQueue.async {
            self.view?.setImage(data: data)
        }
    }
}
