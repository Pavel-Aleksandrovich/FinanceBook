//
//  HistoryDataManager.swift
//  FinanceBook
//
//  Created by pavel mishanin on 23.06.2022.
//

import Foundation

protocol IHistoryDataManager {
    func getHistory(fromDate: Date,
                    toDate: Date,
                    profit: String,
                    completion: @escaping(Result<([HistoryModelResponse]),
                                           Error>) -> ())
    func getHistory(profit: String,
                    date: Date,
                    completion: @escaping(Result<([HistoryModelResponse]),
                                          Error>) -> ())
    func getHistory(profit: String,
                    completion: @escaping(Result<([HistoryModelResponse]),
                                           Error>) -> ()) 
    func create(transaction: TransactionRequest,
                completion: @escaping(Result<(), Error>) -> ())
    func deleteHistoryBy(id: UUID,
                         completion: @escaping (Result<(), Error>) -> ())
}

final class HistoryDataManager {
    
    private let coreDataStorage: CoreDataStorage
    private let globalQueue = DispatchQueue.global(qos: .userInitiated)
    
    init(coreDataStorage: CoreDataStorage) {
        self.coreDataStorage = coreDataStorage
    }
}

extension HistoryDataManager: IHistoryDataManager {
    
    func getHistory(profit: String,
                    date: Date,
                    completion: @escaping(Result<([HistoryModelResponse]),
                                           Error>) -> ()) {
        self.globalQueue.async {
            do {
                let segments = try self.coreDataStorage.getHistory(profit: profit,
                                                                   date: date)
                completion(.success(segments))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getHistory(fromDate: Date,
                    toDate: Date,
                    profit: String,
                    completion: @escaping(Result<([HistoryModelResponse]),
                                           Error>) -> ()) {
        self.globalQueue.async {
            do {
                let segments = try self.coreDataStorage.getHistory(
                    fromDate: fromDate,
                    toDate: toDate,
                    profit: profit)
                
                completion(.success(segments))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func getHistory(profit: String,
                    completion: @escaping(Result<([HistoryModelResponse]),
                                           Error>) -> ()) {
        self.globalQueue.async {
            do {
                let segments = try self.coreDataStorage.getHistory(profit: profit)
                completion(.success(segments))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func create(transaction: TransactionRequest,
                completion: @escaping (Result<(), Error>) -> ()) {
        self.globalQueue.async {
            do {
                try self.coreDataStorage.create(transaction: transaction)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func deleteHistoryBy(id: UUID,
                         completion: @escaping (Result<(), Error>) -> ()) {
        
        self.globalQueue.async {
            do {
                try self.coreDataStorage.deleteHistoryBy(id: id)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
