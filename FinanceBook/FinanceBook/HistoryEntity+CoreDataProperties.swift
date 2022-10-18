//
//  HistoryEntity+CoreDataProperties.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.07.2022.
//
//

import Foundation
import CoreData


extension HistoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HistoryEntity> {
        return NSFetchRequest<HistoryEntity>(entityName: "HistoryEntity")
    }

    @NSManaged public var color: Data
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var value: Int64
    @NSManaged public var date: Date
    @NSManaged public var profit: String

}

extension HistoryEntity : Identifiable {

}

extension HistoryEntity {

    func setValues(from model: TransactionRequest) {
        self.color = model.color
        self.id = model.id
        self.name = model.name
        self.value = Int64(model.amount)
        self.date = model.date
        self.profit = model.profit
    }
}
