//
//  NewsResponse.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import Foundation

struct NewsResponse {
    let id: UUID
    let title: String
    let desctiption: String
    let imageData: Data
    
    init(from model: NewsEntity) {
        self.id = model.id
        self.title = model.title
        self.desctiption = model.content
        self.imageData = model.imageData
    }
}
