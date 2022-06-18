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
}
