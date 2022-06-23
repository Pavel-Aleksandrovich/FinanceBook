//
//  HistoryDataManager.swift
//  FinanceBook
//
//  Created by pavel mishanin on 23.06.2022.
//

import Foundation

protocol IHistoryDataManager {
    func getHistory(completion: @escaping(Result<([HistoryResponse]),
                                          Error>) -> ())
    func create(transaction: TransactionDetailsRequest,
                completion: @escaping(Result<(), Error>) -> ())
    func deleteTransactionBy(id: UUID,
                             completion: @escaping (Result<(), Error>) -> ())
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
    func getHistory(completion: @escaping (Result<([HistoryResponse]),
                                           Error>) -> ()) {
        self.globalQueue.async {
            do {
                let segments = try self.coreDataStorage.getHistory()
                completion(.success(segments))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func create(transaction: TransactionDetailsRequest,
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
    
    func deleteTransactionBy(id: UUID,
                             completion: @escaping (Result<(), Error>) -> ()) {
        
        self.globalQueue.async {
            do {
                try self.coreDataStorage.deleteTransactionBy(id: id)
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
