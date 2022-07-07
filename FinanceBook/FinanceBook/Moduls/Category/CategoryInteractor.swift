//
//  CategoryInteractor.swift
//  FinanceBook
//
//  Created by pavel mishanin on 06.07.2022.
//

import Foundation

protocol ICategoryInteractor: AnyObject {
    func check(_ model: CategoryType?)
    func saveButtonTapped(_ model: CategoryType?)
    func onViewAttached(controller: ICategoryViewController,
                        view: ICategoryView)
}

final class CategoryInteractor {
    
    private let presenter: ICategoryPresenter
    
    init(presenter: ICategoryPresenter) {
        self.presenter = presenter
    }
}

extension CategoryInteractor: ICategoryInteractor {
    
    func check(_ model: CategoryType?) {
        switch model == nil {
        case true:
            self.presenter.showError()
        case false:
            self.presenter.showSuccess()
        }
    }
    
    func saveButtonTapped(_ model: CategoryType?) {
        switch model == nil {
        case true:
            self.presenter.buttonTappedError()
        case false:
            guard let model = model else { return }
            self.presenter.buttonTappedSuccess(model)
        }
    }
    
    func onViewAttached(controller: ICategoryViewController,
                        view: ICategoryView) {
        self.presenter.onViewAttached(controller: controller,
                                      view: view)
    }
}
