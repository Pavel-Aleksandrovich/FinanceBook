//
//  NetworkManager.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

protocol INewsNetworkManager: AnyObject {
    func loadNews(country: String,
                  category: String,
                  completion: @escaping (Result<NewsDTO, Error>) -> ())
    func loadImageDataFrom(url: String,
                           completion: @escaping(Result<UIImage?,
                                                 Error>) -> ())
}

final class NewsNetworkManager {
    
    private enum Api {
        static let key = "&apiKey=7d0b341870634da093c7dd7b06db9891"
        static let defaultKey = "&apiKey=b21393dbff084185b011f3acdc9bd5fb"
    }
    
    private enum EndPoints {
        static let country = "country="
        static let category = "&category="
        static let page = "&pageSize=100"
    }
    
    private let baseUrl = "https://newsapi.org/v2/top-headlines?"
    
    private let session: URLSession
    private let cache = NSCache<NSString, UIImage>()
    
    init(configuration: URLSessionConfiguration? = nil) {
        if let configuration = configuration {
            self.session = URLSession(configuration: configuration)
        }
        else {
            self.session = URLSession(configuration: .default)
        }
    }
}

extension NewsNetworkManager: INewsNetworkManager {
    
    func loadNews(country: String,
                  category: String,
                  completion: @escaping (Result<NewsDTO, Error>) -> ()) {
        let api = self.baseUrl + EndPoints.country + country + EndPoints.page
        + EndPoints.category + category + Api.key

        self.loadData(api: api, completion: completion)
    }
    
    func loadImageDataFrom(url: String,
                           completion: @escaping(Result<UIImage?,
                                                 Error>) -> ()) {
        let cacheKey = NSString(string: url)
        
        if let imageFromCache = cache.object(forKey: cacheKey) {
            completion(.success(imageFromCache))
        } else {
            guard let url = URL(string: url) else { return }
            let request = URLRequest(url: url)
            
            self.session.dataTask(with: request) { data, response, error in
                
                if let error = error {
                    completion(.failure(error))
                }
                
                guard let data = data else { return }

                guard let image = UIImage(data: data) else { return }
                
                self.cache.setObject(image, forKey: cacheKey)
                completion(.success(image))
            }.resume()
        }
    }
}

private extension NewsNetworkManager {
    
    func loadData<T: Decodable>(api: String,
                                completion: @escaping (Result<T, Error>) -> ()) {
        
        guard let url = URL(string: api) else { assert(false) }
        
        let request = URLRequest(url: url)
        
        self.session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            guard let data = data else { return }
            do {
                let newData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(newData))
            }
            catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
