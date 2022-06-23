//
//  ChartDTO.swift
//  FinanceBook
//
//  Created by pavel mishanin on 18.06.2022.
//

import Foundation

struct HistoryResponse {
    let id: UUID
    let name: String
    let color: Data
    let transaction: [TransactionTypeResponse]
    
    init(history: ChartEntity, transaction: [TransactionTypeResponse]) {
        self.id = history.id
        self.name = history.name
        self.color = history.color
        self.transaction = transaction
    }
}

struct TransactionTypeResponse {
    let id: UUID
    let value: Int
    let date: Date

    init(transaction: SegmentEntity) {
        self.id = transaction.id
        self.value = Int(transaction.value)
        self.date = transaction.date
    }
}
