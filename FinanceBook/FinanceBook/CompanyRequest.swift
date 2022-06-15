//
//  CompanyRequest.swift
//  Homework-10
//
//  Created by pavel mishanin on 14.06.2022.
//

import Foundation

struct CompanyRequest {
    let id: UUID
    let name: String
    let employeeCount: String
    
    init(name: String) {
        self.name = name
        self.id = UUID()
        self.employeeCount = "0"
    }
    
    init(company: CompanyViewModel) {
        self.id = company.id
        self.name = company.name
        self.employeeCount = company.employeeCount
    }
}
