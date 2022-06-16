//
//  CoreDataStorage.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import Foundation
import CoreData

final class CoreDataStorage {
    
    static let shared = CoreDataStorage()
    
    private lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FinanceBook")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {}
    
}

extension CoreDataStorage {
    
    func getListNews() throws -> [NewsResponse] {
        let fetchRequest = NewsEntity.fetchRequest()
        let news = try self.context.fetch(fetchRequest)
        return news.compactMap { NewsResponse(from: $0) }
    }
    
    func delete(news: NewsResponse) throws {
        //            let fetchRequest = CompanyEntity.fetchRequest()
        let fetchRequest = NewsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@",
                                             news.id.description)
        
        let news = try self.context.fetch(fetchRequest)
        if let newsForDelete = news.first {
            context.delete(newsForDelete)
            self.saveContext()
        }
        //            fetchRequest.predicate = NSPredicate(format: "id = %@",
        //                                                 company.id.description)
        //
        //            let companies = try context.fetch(fetchRequest)
        //            if let companyForDelete = companies.first {
        //                context.delete(companyForDelete)
        //
        //                self.saveContext()
        //            }
    }
    
    func create(news: NewsRequest) throws {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "NewsEntity",
                                                      in: self.context) else { return }
        let savedNews = try self.getListNews()
        
        if savedNews.contains(where: { $0.title == news.title}) == false {
            let newsEntity = NewsEntity(entity: entity, insertInto: self.context)
            newsEntity.setValue(from: news)
        } else {
            throw CustomError.added
        }
        
        self.saveContext()
    }
}

private extension CoreDataStorage {
    
    func saveContext () {
        if self.context.hasChanges {
            do {
                try self.context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

enum CustomError: String, Error {
    case added = "News Already added"
}
