//
//  SegmentEntity+CoreDataProperties.swift
//  FinanceBook
//
//  Created by pavel mishanin on 17.06.2022.
//
//

import Foundation
import CoreData


extension SegmentEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SegmentEntity> {
        return NSFetchRequest<SegmentEntity>(entityName: "SegmentEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var date: Date
    @NSManaged public var value: Int64
    @NSManaged public var chart: ChartEntity

}

extension SegmentEntity : Identifiable {

}

extension SegmentEntity {
    
    func setValues(from segment: ChartRequestDto) {
        self.id = segment.idSegment
        self.date = segment.date
        self.value = Int64(segment.amount)
    }
}
