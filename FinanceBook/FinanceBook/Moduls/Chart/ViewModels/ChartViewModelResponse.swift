//
//  ChartViewModelResponse.swift
//  FinanceBook
//
//  Created by pavel mishanin on 20.06.2022.
//

import UIKit

struct ChartViewModelResponse {
    let id: UUID
    let name: String
    let color: Data
    let segment: [SegmentViewModelResponse]
    let amount: CGFloat
    var expanded: Bool
    
    init(chart: ChartDTOResponse, segment: [SegmentViewModelResponse]) {
        self.id = chart.id
        self.name = chart.name
        self.color = chart.color
        self.segment = segment
        self.expanded = false
        self.amount = CGFloat(segment.map { $0.value }.reduce(0, +))
    }
}

struct SegmentViewModelResponse {
    let id: UUID
    let value: Int
    let date: Date

    init(segment: SegmentDTOResponse) {
        self.id = segment.id
        self.value = segment.value
        self.date = segment.date
    }
}
