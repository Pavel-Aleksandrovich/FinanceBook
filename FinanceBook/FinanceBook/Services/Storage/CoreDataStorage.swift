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
    
    func getHistory() throws -> [HistoryResponse] {
        
        var historyResponse: [HistoryResponse] = []
        
        let historyEntity = try self.getHistoryEntity()
        
        for i in 0..<historyEntity.count {
            let transactionEntity = try self.getTransactions(from: historyEntity[i])
            let transactionResponse = transactionEntity.compactMap { TransactionTypeResponse(transaction: $0) }
            historyResponse.append(HistoryResponse(history: historyEntity[i],
                                                   transaction: transactionResponse))
        }
        
        return historyResponse
    }
    
    func create(transaction: TransactionDetailsRequest) throws {
        guard let entity = NSEntityDescription.entity(forEntityName: "ChartEntity",
                                                      in: context) else { return }
        
        let savedHistory = try self.getHistoryEntity()
        
        if savedHistory.contains(where: { $0.color == transaction.color}) == false {
            let historyEntity = ChartEntity(entity: entity, insertInto: context)
            historyEntity.setValues(from: transaction)
            self.saveContext()
            try self.add(transaction: transaction, to: historyEntity)
        } else {
            for i in 0..<savedHistory.count {
                if savedHistory[i].color == transaction.color {
                    try self.add(transaction: transaction, to: savedHistory[i])
                }
            }
        }
        
        self.saveContext()
    }
    
    func deleteTransactionBy(id: UUID) throws {
        let fetchRequest = SegmentEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id = %@",
                                             id.description)
        
        if let transactionForDelete = try self.context.fetch(fetchRequest).first {
            context.delete(transactionForDelete)
            self.saveContext()
        }
    }
    
    func deleteHistoryBy(id: UUID) throws {
        let fetchRequest = ChartEntity.fetchRequest()
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
