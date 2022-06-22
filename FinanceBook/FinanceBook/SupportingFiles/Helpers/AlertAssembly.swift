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
    
    static func createLanguageAlert(completion: @escaping(Country) -> ()) -> UIAlertController {
        
        let alert = UIAlertController(title: "Choose Language",
                                      message: nil,
                                      preferredStyle: .actionSheet)
        
        let us = UIAlertAction(title: "us",
                               style: .default) { _ in
            completion(.us)
        }
        let ru = UIAlertAction(title: "ru",
                               style: .default) { _ in
            completion(.ru)
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
    
    static func createSuccessAlert(completion: @escaping() -> ()) -> UIAlertController {
        
        let alert = UIAlertController(title: "Success",
                                      message: nil,
                                      preferredStyle: .alert)
        let continueAction = UIAlertAction(title: Constants.errorAlertOkActionTitle,
                                           style: .cancel) { _ in }
        
        let goBackAction = UIAlertAction(title: "Go Back",
                                         style: .default) { _ in
            completion()
        }
        
        alert.addAction(goBackAction)
        alert.addAction(continueAction)
        
        return alert
    }
}
