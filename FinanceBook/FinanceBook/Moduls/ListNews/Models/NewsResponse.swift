//
//  NewsResponse.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import Foundation

struct NewsResponse: Codable {
    let articles: [ArticleResponse]
}

struct ArticleResponse: Codable {
    let title: String?
    let description: String?
    let urlToImage: String?
}
