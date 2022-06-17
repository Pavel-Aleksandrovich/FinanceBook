//
//  Section.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

enum TypeSection: String, CaseIterable {
    case home
    case sport
    case pets
    case transport
    case car
    case food
    case shopping
    case entertainment
    case health
    
    var color: UIColor {
        switch self {
        case .home: return .magenta
        case .sport: return .brown
        case .pets: return .blue
        case .transport: return .green
        case .car: return .yellow
        case .food: return .red
        case .shopping: return .link
        case .entertainment: return .orange
        case .health: return .systemPink
        }
    }
}
