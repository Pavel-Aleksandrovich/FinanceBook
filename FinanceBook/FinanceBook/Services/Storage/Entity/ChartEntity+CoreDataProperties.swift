//
//  ChartEntity+CoreDataProperties.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//
//

import Foundation
import CoreData


extension ChartEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChartEntity> {
        return NSFetchRequest<ChartEntity>(entityName: "ChartEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var color: Data
    @NSManaged public var segment: NSSet?

}

// MARK: Generated accessors for segment
extension ChartEntity {

    @objc(addSegmentObject:)
    @NSManaged public func addToSegment(_ value: SegmentEntity)

    @objc(removeSegmentObject:)
    @NSManaged public func removeFromSegment(_ value: SegmentEntity)

    @objc(addSegment:)
    @NSManaged public func addToSegment(_ values: NSSet)

    @objc(removeSegment:)
    @NSManaged public func removeFromSegment(_ values: NSSet)

}

extension ChartEntity : Identifiable {

}

extension ChartEntity {
    func setValues(from chart: TransactionDetailsRequest) {
        self.id = chart.id
        self.name = chart.name
        self.color = chart.color
    }
}
