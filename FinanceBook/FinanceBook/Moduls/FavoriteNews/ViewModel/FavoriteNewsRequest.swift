//
//  FavoriteNewsRequest.swift
//  FinanceBook
//
//  Created by pavel mishanin on 21.06.2022.
//

import Foundation

struct FavoriteNewsRequest {
    let id: UUID
    let title: String
    let description: String
    let data: Data
    
    init(viewModel: FavoriteNewsViewModel) {
        self.id = viewModel.id
        self.title = viewModel.title
        self.description = viewModel.description
        self.data = viewModel.data
    }
}
