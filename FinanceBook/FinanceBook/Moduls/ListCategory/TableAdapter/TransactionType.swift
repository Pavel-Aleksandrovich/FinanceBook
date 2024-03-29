//
//  Section.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//

import UIKit

enum ProfitType: String, CaseIterable {
    static var allCases: [ProfitType] = ProfitType.allCases
    
    case income
    case expenses
}

enum ExpensesType: String, CaseIterable {
    case salary
    case present
    case underworking
    
    var color: UIColor {
        switch self {
        case .salary: return .green
        case .present: return .red
        case .underworking: return .magenta
        }
    }
    
    var name: String {
        switch self {
        case .salary: return "Salary"
        case .present: return "Present"
        case .underworking: return "Underworking"
        }
    }
}

enum TransactionType: String, CaseIterable {
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
        case .transport: return #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        case .car: return #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        case .food: return .red
        case .shopping: return .link
        case .entertainment: return .orange
        case .health: return #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        }
    }
    
    var name: String {
        switch self {
        case .home: return "Home"
        case .sport: return "Sport"
        case .pets: return "Pets"
        case .transport: return "Transport"
        case .car: return "Car"
        case .food: return "Food"
        case .shopping: return "Shopping"
        case .entertainment: return "Entertainment"
        case .health: return "Health"
        }
    }
    
    var image: UIImage? {
        switch self {
        case .home: return UIImage(named: self.rawValue)
        case .sport: return UIImage(named: self.rawValue)
        case .pets: return UIImage(named: self.rawValue)
        case .transport: return UIImage(named: self.rawValue)
        case .car: return UIImage(named: self.rawValue)
        case .food: return UIImage(named: self.rawValue)
        case .shopping: return UIImage(named: self.rawValue)
        case .entertainment: return UIImage(named: self.rawValue)
        case .health: return UIImage(named: self.rawValue)
        }
    }
}
