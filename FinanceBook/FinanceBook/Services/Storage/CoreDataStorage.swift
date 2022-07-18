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
    
    private lazy var persistentContainer: NSPersistentContainer = {
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

// MARK: - News modul
extension CoreDataStorage {
    
    func getListNews() throws -> [FavoriteNewsResponse] {
        let fetchRequest = NewsEntity.fetchRequest()
        let news = try self.context.fetch(fetchRequest)
        return news.compactMap { FavoriteNewsResponse(from: $0) }
    }
    
    func delete(news: FavoriteNewsRequest) throws {
        
        let fetchRequest = NewsEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@",
                                             news.id.description)
        
        let news = try self.context.fetch(fetchRequest)
        if let newsForDelete = news.first {
            context.delete(newsForDelete)
            self.saveContext()
        }
    }
    
    func create(news: NewsDetailsRequest) throws {
        
        guard let entity = NSEntityDescription.entity(forEntityName: "NewsEntity",
                                                      in: self.context) else { return }
        let savedNews = try self.getListNews()
        
        if savedNews.contains(where: { $0.title == news.title}) == false {
            let newsEntity = NewsEntity(entity: entity, insertInto: self.context)
            newsEntity.setValue(from: news)
        } else {
            throw StorageError.alreadyInFavorite
        }
        
        self.saveContext()
    }
}

// MARK: - History modul
extension CoreDataStorage {
    
    func getHistory(profit: String,
                    date: Date) throws -> [HistoryModelResponse] {
        
        let fetchRequest = HistoryEntity.fetchRequest()
        let predicate = NSPredicate(format: "profit = %@", "\(profit)")
        
        let datePredicate = NSPredicate(format: "date = %@", date as NSDate)
        
        let mainPredicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [datePredicate, predicate])
        
        fetchRequest.predicate = mainPredicate
        
        let history = try self.context.fetch(fetchRequest)
        
        return history.compactMap { HistoryModelResponse(model: $0) }
    }
    
    func getHistory(profit: String) throws -> [HistoryModelResponse] {
        let fetchRequest = HistoryEntity.fetchRequest()
        
        let predicate = NSPredicate(format: "profit = %@", "\(profit)")
        fetchRequest.predicate = predicate
        
        let history = try self.context.fetch(fetchRequest)
        
        return history.compactMap { HistoryModelResponse(model: $0) }
    }
    
    func getHistory(fromDate: Date,
                        toDate: Date,
                        profit: String) throws -> [HistoryModelResponse] {
        
        let fetchRequest = HistoryEntity.fetchRequest()
        let predicate = NSPredicate(format: "profit = %@", "\(profit)")
        
        let fromPredicate = NSPredicate(format: "date >= %@", fromDate as NSDate)
        let toPredicate = NSPredicate(format: "date <= %@", toDate as NSDate)
        
        let mainPredicate = NSCompoundPredicate(
            andPredicateWithSubpredicates: [predicate,
                                            fromPredicate,
                                            toPredicate])
        
        fetchRequest.predicate = mainPredicate
        
        let history = try self.context.fetch(fetchRequest)
        
        return history.compactMap { HistoryModelResponse(model: $0) }
    }
    
    func create(transaction: TransactionRequest) throws {
        guard let entity = NSEntityDescription.entity(
            forEntityName: "HistoryEntity",
            in: self.context) else { return }

        let fetchRequest = HistoryEntity.fetchRequest()
        let history = try self.context.fetch(fetchRequest)
        let savedHistory = history.compactMap { HistoryModelResponse(model: $0) }
        
        if savedHistory.contains(where: { $0.id == transaction.id}) == false {
            let newHistoryEntity = HistoryEntity(entity: entity, insertInto: self.context)
            newHistoryEntity.setValues(from: transaction)
        }
        self.saveContext()
    }
    
    func deleteHistoryBy(id: UUID) throws {
        let fetchRequest = HistoryEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@",
                                             id.description)
        
        let history = try self.context.fetch(fetchRequest)
        if let historyForDelete = history.first {
            self.context.delete(historyForDelete)
            self.saveContext()
        }
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
    
    private func getTransactions(from history: ChartEntity) throws -> [SegmentEntity] {
        let fetchRequest = SegmentEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "chart.id = %@",
                                             history.id.description)
        
        return try context.fetch(fetchRequest)
    }
    
    private func getHistoryEntity() throws -> [ChartEntity] {
        let fetchRequest = ChartEntity.fetchRequest()
         
        return try self.context.fetch(fetchRequest)
    }
    
    private func add(transaction: TransactionDetailsRequest,
                     to history: ChartEntity) throws {
        
        let savedTransactions = try self.getTransactions(from: history)
        guard let entity = NSEntityDescription.entity(forEntityName: "SegmentEntity",
                                                      in: context) else { return }
        
        let fetchRequest = ChartEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@",
                                             history.id.description)
        
        if savedTransactions.contains(where: { $0.id == transaction.idTransaction}) == false {
            if let historyEntity = try context.fetch(fetchRequest).first {
                let transactionEntity = SegmentEntity(entity: entity,
                                                      insertInto: context)
                transactionEntity.chart = historyEntity
                transactionEntity.setValues(from: transaction)
            }
        }
        
        self.saveContext()
    }
}
