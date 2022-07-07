//
//  CategoryPresenter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 06.07.2022.
//

import Foundation

protocol ICategoryPresenter: AnyObject {
    func showError()
    func showSuccess()
    func buttonTappedError()
    func buttonTappedSuccess(_ model: CategoryType)
    func onViewAttached(controller: ICategoryViewController,
                        view: ICategoryView)
}

final class CategoryPresenter {
    
    private weak var view: ICategoryView?
    private weak var controller: ICategoryViewController?
    
    private let mainQueue = DispatchQueue.main
}

extension CategoryPresenter: ICategoryPresenter {
    
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
    
    func onViewAttached(controller: ICategoryViewController,
                        view: ICategoryView) {
        self.controller = controller
        self.view = view
    }
}
