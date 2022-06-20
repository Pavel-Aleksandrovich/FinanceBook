//
//  ChartRequest.swift
//  FinanceBook
//
//  Created by pavel mishanin on 18.06.2022.
//

import Foundation

struct ChartRequest {
    let id: UUID
    let idSegment: UUID
    let name: String
    let color: Data
    let amount: Int
    let date: Date
    
    init(segments: Segment) {
        self.id = segments.id
        self.idSegment = segments.segment.id
        self.name = segments.name
        self.color = ColorConverter.toData(fromColor: segments.color) ?? Data()
        self.amount = segments.segment.amount
        self.date = segments.segment.date
    }
    
    init?(viewModel: ViewModelRequest?) {
        self.id = UUID()
        self.idSegment = UUID()
        
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
