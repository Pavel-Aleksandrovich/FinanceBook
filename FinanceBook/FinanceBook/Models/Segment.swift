//
//  Segment.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

struct Segment {
    let id: UUID
    let name: String
    let color: UIColor
    let segment: SegmentRequest
    
    var value: CGFloat {
//        return CGFloat(segment.map { $0.amount }.reduce(0, +))
        return 50
    }
    
    init(name: String, color: UIColor, amount: Int, date: Date) {
        self.id = UUID()
        self.name = name
        self.color = color
        self.segment = SegmentRequest(id: UUID(), amount: amount, date: date)
    }
    
//    init(from chartDto: ChartDTO) {
//        self.id = chartDto.id
//        self.name = chartDto.name
//        self.color = ColorConverter.toColor(fromData: chartDto.color)
//        self.value = chartDto.amount
//    }
}

struct SegmentRequest {
    let id: UUID
    let amount: Int
    let date: Date
}

struct ChartViewModel {
    let id: UUID
    let name: String
    let color: UIColor
    let segment: SegmentRequest
    let value: CGFloat
}
