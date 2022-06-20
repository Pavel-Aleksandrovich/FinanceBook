//
//  NewSegmentAssembly.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

enum NewSegmentAssembly {
    
    static func build() -> UIViewController {
        
        let presenter = NewSegmentPresenter()
        let dataManager = DataManager()
        let validator = SegmentValidator()
        let interactor = NewSegmentInteractor(presenter: presenter,
                                              dataManager: dataManager,
                                              validator: validator)
        let router = NewSegmentRouter()
        let controller = NewSegmentViewController(interactor: interactor,
                                                  router: router)
        router.controller = controller
        
        return controller
    }
}
