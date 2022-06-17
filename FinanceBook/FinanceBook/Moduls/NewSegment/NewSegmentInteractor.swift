//
//  NewSegmentInteractor.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import Foundation

protocol INewSegmentInteractor: AnyObject {
    func onViewAttached(controller: INewSegmentViewController,
                        view: INewSegmentView)
}

final class NewSegmentInteractor {
    
    private let presenter: INewSegmentPresenter
    
    init(presenter: INewSegmentPresenter) {
        self.presenter = presenter
    }
}

extension NewSegmentInteractor: INewSegmentInteractor {
    
    func onViewAttached(controller: INewSegmentViewController,
                        view: INewSegmentView) {
        self.presenter.onViewAttached(controller: controller,
                                      view: view)
    }
}
