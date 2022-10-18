//
//  HistoryValidateRequest.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.07.2022.
//

import UIKit

struct HistoryValidateRequest {
    let name: String?
    let amount: String?
    let date: String?
    let color: UIColor?
    let profit: String?
}

struct TransactionRequest {
    let id: UUID
    let name: String
    let color: Data
    let amount: Int
    let date: Date
    let profit: String
    
    init?(viewModel: HistoryValidateRequest?) {
        self.id = UUID()
        
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
        
        guard let profit = viewModel?.profit else { return nil }
        self.profit = profit
    }
}

