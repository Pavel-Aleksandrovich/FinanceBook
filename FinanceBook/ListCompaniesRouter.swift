//
//  ListCompaniesRouter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

protocol IListNewsRouter: AnyObject {
    func showListEmployeesModule(_ company: CompanyRequest)
    func showAlert(complition: @escaping(CompanyRequest) -> ())
    func showErrorAlert(_ error: String)
}

final class ListNewsRouter {
    
    weak var controller: UIViewController?
}

extension ListNewsRouter: IListCompaniesRouter {
    
    func showListEmployeesModule(_ company: CompanyRequest) {
    }
    
    func showAlert(complition: @escaping(CompanyRequest) -> ()) {
    }
    
    func showErrorAlert(_ error: String) {
    }
}
