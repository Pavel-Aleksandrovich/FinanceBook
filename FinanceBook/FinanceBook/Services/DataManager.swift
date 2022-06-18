//
//  DataManager.swift
//  FinanceBook
//
//  Created by pavel mishanin on 16.06.2022.
//

import Foundation

protocol INewsDataManager {
    func getListNews(completion: @escaping(Result<([NewsResponse]),
                                           Error>) -> ())
    func create(news: NewsRequest,
                completion: @escaping(Result<(), Error>) -> ())
    func delete(news: NewsResponse,
                completion: @escaping(Result<(),
                                      Error>) -> ())
}

protocol IChartDataManager {
    func getListSegments(completion: @escaping(Result<([ChartDTO]),
                                               Error>) -> ())
    func create(segment: ChartRequest,
                completion: @escaping(Result<(), Error>) -> ())
    func delete(segment: ChartDTO,
                completion: @escaping(Result<(),
                                      Error>) -> ())
    func deleteSegment(_ segment: SegmentDTO,
                       from chart: ChartDTO,
                       completion: @escaping (Result<(), Error>) -> ())
}

final class DataManager {
    
    private let coreDataStorage: CoreDataStorage
    
    init(coreDataStorage: CoreDataStorage = .shared) {
        self.coreDataStorage = coreDataStorage
    }
}

extension DataManager: INewsDataManager {
    
    func getListNews(completion: @escaping(Result<([NewsResponse]),
                                           Error>) -> ()) {
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

extension DataManager: IChartDataManager {
    
    func getListSegments(completion: @escaping (Result<([ChartDTO]),
                                                Error>) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                let segments = try self.coreDataStorage.getCharts()
                completion(.success(segments))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func create(segment: ChartRequest,
                completion: @escaping (Result<(), Error>) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try self.coreDataStorage.create(chart: segment)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    
    func deleteSegment(_ segment: SegmentDTO,
                       from chart: ChartDTO,
                       completion: @escaping (Result<(), Error>) -> ()) {
        
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try self.coreDataStorage.deleteSegment(segment, from: chart)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
    func delete(segment: ChartDTO,
                completion: @escaping (Result<(), Error>) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            do {
                try self.coreDataStorage.delete(chart: segment)
                completion(.success(()))
            } catch {
                completion(.failure(error))
            }
        }
    }
}
