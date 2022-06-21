//
//  NetworkManager.swift
//  FinanceBook
//
//  Created by pavel mishanin on 15.06.2022.
//

import UIKit

final class NetworkManager {
    
    private enum Api {
        static let current = "https://api.weatherapi.com/v1/current.json?key=1d91263cb358427082175537220406&q="
        static let history = "https://api.weatherapi.com/v1/history.json?key=1d91263cb358427082175537220406&q="
    }
    
    private enum EndPoints {
        static let date = "&dt="
        static let https = "https:"
    }
    
    private let session: URLSession
    private let cache = NSCache<NSString, UIImage>()
    
    init(configuration: URLSessionConfiguration? = nil) {
        if let configuration = configuration {
            self.session = URLSession(configuration: configuration)
        }
        else {
            self.session = URLSession(configuration: URLSessionConfiguration.default)
        }
    }
}
//7d0b341870634da093c7dd7b06db9891
extension NetworkManager {
    
    func loadNews(language: String,
                  category: String,
                  page: Int,
                  completion: @escaping (Result<NewsDTO, Error>) -> ()) {
        let api = "https://newsapi.org/v2/top-headlines?country=\(language)&pageSize=100&category=\(category)&apiKey=b21393dbff084185b011f3acdc9bd5fb"
        //        let api = "https://newsapi.org/v2/top-headlines?country=us&page=\(page)&apiKey=b21393dbff084185b011f3acdc9bd5fb"
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

private extension NetworkManager {
    
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
