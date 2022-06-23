//
//  NewsDataManager.swift
//  FinanceBook
//
//  Created by pavel mishanin on 23.06.2022.
//

import Foundation

protocol INewsDataManager {
    func getListNews(completion: @escaping(Result<([FavoriteNewsResponse]),
                                           Error>) -> ())
    func create(news: NewsDetailsRequest,
                completion: @escaping(Result<(), Error>) -> ())
    func delete(news: FavoriteNewsRequest,
                completion: @escaping(Result<(),
                                      Error>) -> ())
}

final class NewsDataManager {
    
    private let coreDataStorage: CoreDataStorage
    private let globalQueue = DispatchQueue.global(qos: .userInitiated)
    
    init(coreDataStorage: CoreDataStorage) {
        self.coreDataStorage = coreDataStorage
    }
}

extension NewsDataManager: INewsDataManager {
    func getListNews(completion: @escaping(Result<([FavoriteNewsResponse]),
                                           Error>) -> ()) {
        self.globalQueue.async {
            do {
                let news = try self.coreDataStorage.getListNews()
                completion(.success(news))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func create(news: NewsDetailsRequest,
                completion: @escaping(Result<(), Error>) -> ()) {
        self.globalQueue.async {
            do {
                try self.coreDataStorage.create(news: news)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func delete(news: FavoriteNewsRequest,
                completion: @escaping(Result<(), Error>) -> ()) {
        self.globalQueue.async {
            do {
                try self.coreDataStorage.delete(news: news)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
