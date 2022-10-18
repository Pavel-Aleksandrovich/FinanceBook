//
//  CategoryPresenter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 06.07.2022.
//

import Foundation

protocol IListCategoryPresenter: AnyObject {
    func showError()
    func showSuccess()
    func buttonTappedError()
    func buttonTappedSuccess(_ model: CategoryType)
    func onViewAttached(controller: IListCategoryViewController,
                        view: IListCategoryView)
}

final class ListCategoryPresenter {
    
    private weak var view: IListCategoryView?
    private weak var controller: IListCategoryViewController?
    
    private let mainQueue = DispatchQueue.main
}

extension ListCategoryPresenter: IListCategoryPresenter {
    
    func showError() {
        self.view?.updateSaveButtonState(false)
    }
    
    func showSuccess() {
        self.view?.updateSaveButtonState(true)
    }
    
    func buttonTappedError() {
        self.view?.showShakeAnimation()
    }
    
    func buttonTappedSuccess(_ model: CategoryType) {
        self.controller?.buttonTappedSuccess(model)
    }
    
    func onViewAttached(controller: IListCategoryViewController,
                        view: IListCategoryView) {
        self.controller = controller
        self.view = view
    }
}
