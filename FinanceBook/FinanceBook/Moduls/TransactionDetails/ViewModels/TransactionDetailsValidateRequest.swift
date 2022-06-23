//
//  TransactionDetailsValidateRequest.swift
//  FinanceBook
//
//  Created by pavel mishanin on 20.06.2022.
//

import UIKit

struct TransactionDetailsValidateRequest {
    let name: String?
    let amount: String?
    let date: String?
    let color: UIColor?
    
    init(name: String?, amount: String?, date: String?, color: UIColor?) {
        self.name = name
        self.amount = amount
        self.date = date
        self.color = color
    }
}
