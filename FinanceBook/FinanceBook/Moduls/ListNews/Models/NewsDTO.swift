//
//  News.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import Foundation

struct NewsDTO: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let title: String?
    let description: String?
    let urlToImage: String?
}

struct NewsViewModel: Codable {
    let title: String
    let description: String
    let url: String
}

