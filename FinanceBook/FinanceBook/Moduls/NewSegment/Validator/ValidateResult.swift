//
//  ValidateResult.swift
//  FinanceBook
//
//  Created by pavel mishanin on 20.06.2022.
//

import Foundation

enum ValidateResult {
    case success(ValidateSuccess)
    case error(ValidateError)
}

enum ValidateSuccess {
    case name
    case amount
    case date
    case all
}

enum ValidateError {
    case name
    case amount
    case date
}
