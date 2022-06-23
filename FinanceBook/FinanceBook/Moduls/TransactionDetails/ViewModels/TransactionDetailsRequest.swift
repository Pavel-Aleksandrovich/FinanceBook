//
//  TransactionDetailsRequest.swift
//  FinanceBook
//
//  Created by pavel mishanin on 18.06.2022.
//

import Foundation

struct TransactionDetailsRequest {
    let id: UUID
    let idTransaction: UUID
    let name: String
    let color: Data
    let amount: Int
    let date: Date
    
    init?(viewModel: TransactionDetailsValidateRequest?) {
        self.id = UUID()
        self.idTransaction = UUID()
        
        guard let name = viewModel?.name else { return nil }
        self.name = name
        
        guard let amountString = viewModel?.amount,
              let amount = Int(amountString) else { return nil }
        self.amount = amount
        
        guard let dateString = viewModel?.date,
              let date = DateConverter.getDateFrom(string: dateString)
        else { return nil }
        self.date = date
        
        guard let color = viewModel?.color,
              let colorData = ColorConverter.toData(fromColor: color)
        else { return  nil }
        self.color = colorData
    }
}
