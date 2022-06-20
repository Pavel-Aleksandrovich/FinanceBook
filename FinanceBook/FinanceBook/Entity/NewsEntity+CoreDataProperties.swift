//
//  NewsEntity+CoreDataProperties.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//
//

import Foundation
import CoreData


extension NewsEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsEntity> {
        return NSFetchRequest<NewsEntity>(entityName: "NewsEntity")
    }

    @NSManaged public var id: UUID
    @NSManaged public var title: String
    @NSManaged public var content: String
    @NSManaged public var imageData: Data

}

extension NewsEntity : Identifiable {

}

extension NewsEntity {
    
    func setValue(from model: NewsRequest) {
        self.id = model.id
        self.title = model.title
        self.content = model.desctiption
        self.imageData = model.imageData
    }
}
