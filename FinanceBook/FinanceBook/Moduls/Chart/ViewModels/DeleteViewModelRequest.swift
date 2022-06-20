//
//  DeleteViewModelRequest.swift
//  FinanceBook
//
//  Created by pavel mishanin on 20.06.2022.
//

import Foundation

struct DeleteViewModelRequest {
    let id: UUID
    let idSegment: UUID
    let segmentsCount: Int
}
