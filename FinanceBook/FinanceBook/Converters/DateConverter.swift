//
//  DateConverter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 19.06.2022.
//

import Foundation

enum DateConverter {
    static func toStringFrom(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yy"
        
        return formatter.string(from: date)
    }
}
