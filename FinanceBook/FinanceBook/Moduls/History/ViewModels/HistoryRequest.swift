//
//  HistoryRequest.swift
//  FinanceBook
//
//  Created by pavel mishanin on 20.06.2022.
//

import Foundation

struct HistoryRequest {
    let id: UUID
    let idSegment: UUID
    let transactionCount: Int
}
