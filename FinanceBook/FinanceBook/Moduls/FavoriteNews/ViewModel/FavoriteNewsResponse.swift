//
//  NewsResponse.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import Foundation

struct FavoriteNewsResponse {
    let id: UUID
    let title: String
    let description: String
    let imageData: Data
    
    init(from model: NewsEntity) {
        self.id = model.id
        self.title = model.title
        self.description = model.content
        self.imageData = model.imageData
    }
}
