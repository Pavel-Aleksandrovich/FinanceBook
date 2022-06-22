//
//  File.swift
//  FinanceBook
//
//  Created by pavel mishanin on 23.06.2022.
//

import Foundation

struct NewsViewModel {
    let title: String
    let description: String
    let urlToImage: String
    
    init?(from news: ArticleResponse) {
        guard let title = news.title,
              let description = news.description,
              let urlToImage = news.urlToImage
        else { return nil }
        self.title = title
        
//        guard let description = news.description else { return nil }
        self.description = description
        
//        guard let urlToImage = news.urlToImage else { return nil }
        self.urlToImage = urlToImage
    }
}
