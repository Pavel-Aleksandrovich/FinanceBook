//
//  EmployeeRequest.swift
//  Homework-10
//
//  Created by pavel mishanin on 14.06.2022.
//

import Foundation

struct EmployeeRequest {
    let id: UUID
    let name: String
    let age: Int
    let position: String
    let experience: String?
    let education: String?
    
//    init(employee: EmployeeViewModel) {
//        self.id = employee.id
//        self.name = employee.name
//        self.age = employee.age
//        self.experience = employee.experience
//        self.position = employee.position
//        self.education = employee.education
//    }
    
    init(name: String,
         age: String,
         position: String,
         education: String? = nil,
         experience: String? = nil) {
        self.id = UUID()
        self.name = name
        self.age = Int(age) ?? 0
        self.experience = experience
        self.position = position
        self.education = education
    }
}
