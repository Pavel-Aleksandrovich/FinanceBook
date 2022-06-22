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
    let transactionType: [TransactionTypeResponse]
    
    init(chart: ChartEntity, segment: [TransactionTypeResponse]) {
        self.id = chart.id
        self.name = chart.name
        self.color = chart.color
        self.transactionType = segment
    }
}

struct TransactionTypeResponse {
    let id: UUID
    let value: Int
    let date: Date

    init(segment: SegmentEntity) {
        self.id = segment.id
        self.value = Int(segment.value)
        self.date = segment.date
    }
}
