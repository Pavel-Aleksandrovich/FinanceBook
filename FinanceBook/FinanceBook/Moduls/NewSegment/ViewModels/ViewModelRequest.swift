//
//  ViewModelRequest.swift
//  FinanceBook
//
//  Created by pavel mishanin on 20.06.2022.
//

import UIKit

struct ViewModelRequest {
    let id: UUID
    let idSegment: UUID
    let name: String?
    let amount: String?
    let date: String?
    let color: UIColor?
    
    init(name: String?, amount: String?, date: String?, color: UIColor?) {
        self.id = UUID()
        self.idSegment = UUID()
        self.name = name
        self.amount = amount
        self.date = date
        self.color = color
    }
//
//    init(chart: ChartDTO, segment: SegmentDTO) {
//        self.id = chart.id
//        self.idSegment = segment.id
//        self.name = chart.name
//        self.amount = chart.
//        self.date = DateConverter.toStringFrom(date: segment.date)
//        self.color = ColorConverter.toColor(fromData: chart.color)
//
//
//
//    }
}

