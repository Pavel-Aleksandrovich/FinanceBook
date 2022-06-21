//
//  FavoriteDetailsViewModel.swift
//  FinanceBook
//
//  Created by pavel mishanin on 21.06.2022.
//

import Foundation

struct FavoriteNewsViewModel {
    let id: UUID
    let title: String
    let description: String
    let data: Data
    
    init(viewModel: FavoriteNewsResponse) {
        self.id = viewModel.id
        self.title = viewModel.title
        self.description = viewModel.description
        self.data = viewModel.imageData
    }
}
