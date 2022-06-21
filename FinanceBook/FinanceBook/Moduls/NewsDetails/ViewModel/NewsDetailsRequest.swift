//
//  NewsRequest.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import Foundation

struct NewsDetailsRequest {
    let id: UUID
    let title: String
    let desctiption: String
    let imageData: Data

    init(title: String,
         desctiption: String,
         imageData: Data) {
        self.id = UUID()
        self.title = title
        self.desctiption = desctiption
        self.imageData = imageData
    }
}
