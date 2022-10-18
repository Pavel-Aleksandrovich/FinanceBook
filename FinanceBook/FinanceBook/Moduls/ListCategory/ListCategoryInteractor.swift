//
//  CategoryInteractor.swift
//  FinanceBook
//
//  Created by pavel mishanin on 06.07.2022.
//

import Foundation

protocol IListCategoryInteractor: AnyObject {
    func check(_ model: CategoryType?)
    func saveButtonTapped(_ model: CategoryType?)
    func onViewAttached(controller: IListCategoryViewController,
                        view: IListCategoryView)
}

final class ListCategoryInteractor {
    
    private let presenter: IListCategoryPresenter
    
    init(presenter: IListCategoryPresenter) {
        self.presenter = presenter
    }
}

extension ListCategoryInteractor: IListCategoryInteractor {
    
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
    
    func onViewAttached(controller: IListCategoryViewController,
                        view: IListCategoryView) {
        self.presenter.onViewAttached(controller: controller,
                                      view: view)
    }
}
