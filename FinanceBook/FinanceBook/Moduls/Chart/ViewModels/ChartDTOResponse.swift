//
//  ChartDTO.swift
//  FinanceBook
//
//  Created by pavel mishanin on 18.06.2022.
//

import UIKit

struct ChartDTOResponse {
    let id: UUID
    let name: String
    let color: Data
    let segment: [SegmentDTOResponse]
    
    init(chart: ChartEntity, segment: [SegmentDTOResponse]) {
        self.id = chart.id
        self.name = chart.name
        self.color = chart.color
        self.segment = segment
    }
}

struct SegmentDTOResponse {
    let id: UUID
    let value: Int
    let date: Date

    init(segment: SegmentEntity) {
        self.id = segment.id
        self.value = Int(segment.value)
        self.date = segment.date
    }
}
