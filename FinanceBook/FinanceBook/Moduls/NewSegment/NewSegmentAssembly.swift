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
        let interactor = NewSegmentInteractor(presenter: presenter)
        let router = NewSegmentRouter()
        let controller = NewSegmentViewController(interactor: interactor,
                                                   router: router)
        router.controller = controller
        
        return controller
    }
}
