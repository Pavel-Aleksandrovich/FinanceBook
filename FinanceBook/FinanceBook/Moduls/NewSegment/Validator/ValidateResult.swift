//
//  ValidateResult.swift
//  FinanceBook
//
//  Created by pavel mishanin on 20.06.2022.
//

import Foundation

enum ValidateResult {
    case success(ValidateSuccess)
    case error(String)
}

enum ValidateSuccess {
    case name
    case amount
    case date
    case all
}

enum ValidateError: String {
    case name = "Enter name"
    case amount = "Enter emount"
    case amount2 = "Error number"
    case date = "Enter date"
    case date2 = "Error date"
}
