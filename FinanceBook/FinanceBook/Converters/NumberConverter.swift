//
//  NumberConverter.swift
//  FinanceBook
//
//  Created by pavel mishanin on 19.06.2022.
//

import Foundation

enum NumberConverter {
    static func toStringFrom(int: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        let string = formatter.string(from: NSNumber(value: int)) ?? ""
        return string + " ₽"
    }
}
