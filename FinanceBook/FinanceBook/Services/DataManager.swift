//
//  DataManager.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import Foundation

protocol IDataManager {
    func getListNews(completion: @escaping(Result<([NewsResponse]),
                                            Error>) -> ())
    func create(news: NewsRequest,
                completion: @escaping(Result<(), Error>) -> ())
    func delete(news: NewsResponse,
                completion: @escaping(Result<(),
                                       Error>) -> ())
}

final class DataManager {
    
    private let coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage = .shared) {
        self.coreDataStorage = coreDataStorage
    }
}

extension DataManager: IDataManager {
    
    func getListNews(completion: @escaping(Result<([NewsResponse]), Error>) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                let news = try self.coreDataStorage.getListNews()
                completion(.success(news))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func create(news: NewsRequest,
                completion: @escaping(Result<(), Error>) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try self.coreDataStorage.create(news: news)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            } catch is CustomError {
                completion(.failure(CustomError.added))
            }
        }
    }
    
    func delete(news: NewsResponse,
                completion: @escaping(Result<(), Error>) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try self.coreDataStorage.delete(news: news)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
