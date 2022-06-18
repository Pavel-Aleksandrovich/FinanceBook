//
//  ChartDTO.swift
//  FinanceBook
//
//  Created by pavel mishanin on 18.06.2022.
//

import UIKit

struct ChartDTO {
    let id: UUID
    let name: String
    let color: Data
    let segment: [SegmentDTO]
    var expanded: Bool
    
    var amount: CGFloat {
        return CGFloat(segment.map { $0.value }.reduce(0, +))
    }
    
    init(chart: ChartEntity, segment: [SegmentDTO]) {
        self.id = chart.id
        self.name = chart.name
        self.color = chart.color
        self.segment = segment
        self.expanded = false
    }
}

struct SegmentDTO {
    let id: UUID
    let value: Int
    let date: Date

    init(segment: SegmentEntity) {
        self.id = segment.id
        self.value = Int(segment.value)
        self.date = segment.date
    }
}
