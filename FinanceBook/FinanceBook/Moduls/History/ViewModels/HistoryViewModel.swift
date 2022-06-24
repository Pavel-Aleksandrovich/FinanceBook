//
//  HistoryViewModel.swift
//  FinanceBook
//
//  Created by pavel mishanin on 20.06.2022.
//

import UIKit

struct HistoryViewModel {
    let id: UUID
    let name: String
    let color: Data
    let transaction: [TransactionTypeViewModel]
    let amount: CGFloat
    var expanded: Bool
    
    init(history: HistoryResponse, transaction: [TransactionTypeViewModel]) {
        self.id = history.id
        self.name = history.name
        self.color = history.color
        self.transaction = transaction
        self.expanded = false
        self.amount = CGFloat(transaction.map { $0.value }.reduce(0, +))
    }
}

struct TransactionTypeViewModel {
    let id: UUID
    let value: Int
    let date: Date
    
    init(transaction: TransactionTypeResponse) {
        self.id = transaction.id
        self.value = transaction.value
        self.date = transaction.date
    }
}
