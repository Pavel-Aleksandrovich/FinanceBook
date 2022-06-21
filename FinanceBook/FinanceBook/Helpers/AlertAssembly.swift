//
//  AlertAssembly.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import UIKit

enum Country: String {
    case us
    case ru
    
    var name: String {
        switch self {
        case .us: return "US"
        case .ru: return "RU"
        }
    }
}

enum AlertAssembly {
    
    private enum Constants {
        static let errorAlertOkActionTitle = "Ok"
    }
    
    static func createLanguageAlert(complition: @escaping(Country) -> ()) -> UIAlertController {
        
        let alert = UIAlertController(title: "Choose Language",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        let us = UIAlertAction(title: "us",
                               style: .default) { _ in
            complition(.us)
        }
        let ru = UIAlertAction(title: "ru",
                               style: .default) { _ in
            complition(.ru)
        }
        
        alert.addAction(us)
        alert.addAction(ru)
        
        return alert
    }
    
    static func createAlert(_ title: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title,
                                      message: nil,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: Constants.errorAlertOkActionTitle,
                                     style: .cancel) { _ in }
        alert.addAction(okAction)
        
        return alert
    }
    
    static func createSuccessAlert(complition: @escaping() -> ()) -> UIAlertController {
        
        let alert = UIAlertController(title: "Saccuss",
                                      message: nil,
                                      preferredStyle: .alert)
        let continueAction = UIAlertAction(title: Constants.errorAlertOkActionTitle,
                                           style: .cancel) { _ in }
        
        let goBackAction = UIAlertAction(title: "goBack",
                                         style: .default) { _ in
            complition()
        }
        
        alert.addAction(goBackAction)
        alert.addAction(continueAction)
        
        return alert
    }
}
