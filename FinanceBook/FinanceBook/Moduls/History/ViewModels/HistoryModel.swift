//
//  HistoryModel.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.07.2022.
//

import Foundation

struct HistoryModel {
    let color: Data
    let id: UUID
    let name: String
    let value: Int
    let date: Date
    let profit: String
    
    init(model: HistoryModelResponse) {
        self.color = model.color
        self.id = model.id
        self.name = model.name
        self.value = model.value
        self.date = model.date
        self.profit = model.profit
    }
}

struct HistoryModelResponse {
    let color: Data
    let id: UUID
    let name: String
    let value: Int
    let date: Date
    let profit: String
    
    init(model: HistoryEntity) {
        self.color = model.color
        self.id = model.id
        self.name = model.name
        self.value = Int(model.value)
        self.date = model.date
        self.profit = model.profit
    }
}
