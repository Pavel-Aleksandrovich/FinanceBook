//
//  NewsNetworkError.swift
//  FinanceBook
//
//  Created by pavel mishanin on 22.06.2022.
//

import Foundation

enum NewsNetworkError: String, Error {
    case invalidData = "Invalid Data"
    case invalidImage = "Invalid Image"
    case invalidUrl = "Invalid URL"
}
