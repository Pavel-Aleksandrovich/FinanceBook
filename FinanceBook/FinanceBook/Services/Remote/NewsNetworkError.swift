//
//  File.swift
//  FinanceBook
//
//  Created by pavel mishanin on 22.06.2022.
//

import Foundation

enum NewsNetworkError: String, Error {
    case invalidData = "Invalid Data"
    case invalidImage = "Invalid Image"
    case unableToComplete = "Не удается обработать ваш запрос. Пожалуйста, проверьте ваше интернет-соединение."
    case invalidResponce = "Ошибка соединения. Пожалуйста, попробуйте еще раз."
}
