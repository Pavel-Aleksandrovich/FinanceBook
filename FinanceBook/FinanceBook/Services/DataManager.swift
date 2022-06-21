//
//  DataManager.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
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

protocol IChartDataManager {
    func getListSegments(completion: @escaping(Result<([ChartDTOResponse]),
                                               Error>) -> ())
    func create(segment: ChartRequestDto,
                completion: @escaping(Result<(), Error>) -> ())
    func deleteSegment(_ viewModel: DeleteViewModelRequest,
                       completion: @escaping (Result<(), Error>) -> ())
}

final class DataManager {
    
    private let coreDataStorage: CoreDataStorage
    private let globalQueue = DispatchQueue.global(qos: .userInitiated)
    
    init(coreDataStorage: CoreDataStorage = .shared) {
        self.coreDataStorage = coreDataStorage
    }
}

extension DataManager: INewsDataManager {
    
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

extension DataManager: IChartDataManager {
    
    func getListSegments(completion: @escaping (Result<([ChartDTOResponse]),
                                                Error>) -> ()) {
        self.globalQueue.async {
            do {
                let segments = try self.coreDataStorage.getCharts()
                completion(.success(segments))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func create(segment: ChartRequestDto,
                completion: @escaping (Result<(), Error>) -> ()) {
        self.globalQueue.async {
            do {
                try self.coreDataStorage.create(chart: segment)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func deleteSegment(_ viewModel: DeleteViewModelRequest,
                       completion: @escaping (Result<(), Error>) -> ()) {
        
        self.globalQueue.async {
            do {
                try self.coreDataStorage.deleteSegment(viewModel)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
